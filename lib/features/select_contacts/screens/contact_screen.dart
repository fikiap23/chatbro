import 'package:chatbro/common/utils/Custome_theme.dart';
import 'package:chatbro/common/utils/coloors.dart';

import 'package:chatbro/features/chat/screens/mobile_chat_screen.dart';
import 'package:chatbro/features/chat/widgets/custome_icon_button.dart';
import 'package:chatbro/features/group/screens/create_group_screen.dart';

import 'package:chatbro/features/select_contacts/controller/contact_controller.dart';
import 'package:chatbro/features/select_contacts/widgets/contact_card.dart';
import 'package:chatbro/models/group.dart';
import 'package:chatbro/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends ConsumerWidget {
  static const String routeName = '/select-contact';
  const ContactScreen({super.key});

  shareSmsLink(phoneNumber) async {
    Uri sms = Uri.parse(
      "sms:$phoneNumber?body= Ayo gabung ke aplikasi kami https://whatsapp.com/dl/",
    );
    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select contact',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3),
            ref.watch(getAllContactsProvider).when(
              data: (allContacts) {
                return Text(
                  "${allContacts[0].length} contact${allContacts[0].length == 1 ? '' : 's'}",
                  style: const TextStyle(fontSize: 12),
                );
              },
              error: (e, t) {
                return const SizedBox();
              },
              loading: () {
                return const Text(
                  'counting...',
                  style: TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
        actions: [
          CustomIconButton(onPressed: () {}, icon: Icons.search),
          CustomIconButton(onPressed: () {}, icon: Icons.more_vert),
        ],
      ),
      body: ref.watch(getAllContactsProvider).when(
        data: (allContacts) {
          return ListView.builder(
            itemCount: allContacts[0].length + allContacts[1].length,
            itemBuilder: (context, index) {
              late UserModel firebaseContacts;
              late UserModel phoneContacts;

              if (index < allContacts[0].length) {
                firebaseContacts = allContacts[0][index];
              } else {
                phoneContacts = allContacts[1][index - allContacts[0].length];
              }
              return index < allContacts[0].length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == 0)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myListTile(
                                leading: Icons.group,
                                text: 'New group',
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, CreateGroupScreen.routeName);
                                },
                              ),
                              myListTile(
                                leading: Icons.contacts,
                                text: 'New contact',
                                trailing: Icons.qr_code,
                                onPressed: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Text(
                                  'Contacts on WhatsApp',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: context.theme.greyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ContactCard(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MobileChatScreen.routeName,
                              arguments: {
                                // 'name': firebaseContacts.name,
                                // 'uid': firebaseContacts.uid,
                                // 'isGroupChat': false,
                                // 'profilePic': firebaseContacts.profilePic,
                                'user': UserModel(
                                  name: firebaseContacts.name,
                                  uid: firebaseContacts.uid,
                                  profilePic: firebaseContacts.profilePic,
                                  phoneNumber: firebaseContacts.phoneNumber,
                                  isOnline: false,
                                  groupId: [],
                                ),
                                'group': Group(
                                  groupId: '',
                                  name: '',
                                  groupPic: '',
                                  lastMessage: '',
                                  membersUid: [],
                                  senderId: '',
                                  timeSent: DateTime.now(),
                                ),
                                'isGroupChat': false,
                                'nameContact': firebaseContacts.name
                              },
                            );
                          },
                          contactSource: firebaseContacts,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index == allContacts[0].length)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              'Invite to WhatsApp',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: context.theme.greyColor,
                              ),
                            ),
                          ),
                        ContactCard(
                          contactSource: phoneContacts,
                          onTap: () => shareSmsLink(phoneContacts.phoneNumber),
                        )
                      ],
                    );
            },
          );
        },
        error: (e, t) {
          return null;
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(
              color: context.theme.authAppbarTextColor,
            ),
          );
        },
      ),
    );
  }

  ListTile myListTile({
    required IconData leading,
    required String text,
    required VoidCallback onPressed,
    IconData? trailing,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(top: 10, left: 20, right: 10),
      leading: GestureDetector(
        onTap: onPressed,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Coloors.greenDark,
          child: Icon(
            leading,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        trailing,
        color: Coloors.greyDark,
      ),
    );
  }
}
