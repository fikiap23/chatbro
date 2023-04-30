import 'package:chatbro/features/select_contacts/screens/contact_screen.dart';
import 'package:chatbro/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:chatbro/common/utils/coloors.dart';
import 'package:chatbro/common/widgets/loader.dart';
import 'package:chatbro/features/chat/controller/chat_controller.dart';
import 'package:chatbro/features/chat/screens/mobile_chat_screen.dart';
import 'package:chatbro/models/chat_contact.dart';
import 'package:chatbro/models/group.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<ChatContact>>(
                  stream: ref.watch(chatControllerProvider).getChatContacts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var chatContactData = snapshot.data![index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, MobileChatScreen.routeName,
                                    arguments: {
                                      'user': UserModel(
                                        name: chatContactData.name,
                                        uid: chatContactData.contactId,
                                        profilePic: chatContactData.profilePic,
                                        phoneNumber:
                                            chatContactData.phoneNumber,
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
                                    });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListTile(
                                  textColor: blackColor,
                                  title: Text(
                                    chatContactData.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      chatContactData.lastMessage,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      chatContactData.profilePic,
                                    ),
                                    radius: 30,
                                  ),
                                  trailing: Text(
                                    DateFormat.Hm()
                                        .format(chatContactData.timeSent),
                                    style: const TextStyle(
                                      color: blackColor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // const Divider(color: dividerColor, indent: 85),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, ContactScreen.routeName);
        },
        backgroundColor: appBarColor,
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}
