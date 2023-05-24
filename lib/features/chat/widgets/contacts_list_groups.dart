import 'package:chatbro/features/select_contacts/screens/contact_screen.dart';
import 'package:chatbro/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:chatbro/common/utils/coloors.dart';
import 'package:chatbro/common/widgets/loader.dart';
import 'package:chatbro/features/chat/controller/chat_controller.dart';
import 'package:chatbro/features/chat/screens/mobile_chat_screen.dart';

import 'package:chatbro/models/group.dart';

class ContactsListGroup extends ConsumerWidget {
  const ContactsListGroup({Key? key}) : super(key: key);

  String getLastMessageFormattedDate(DateTime time) {
    final now = DateTime.now();
    final timeSent = time.toLocal(); // Konversi ke zona waktu lokal

    String formattedDate = '';

    if (timeSent.year == now.year &&
        timeSent.month == now.month &&
        timeSent.day == now.day) {
      formattedDate = DateFormat.Hm().format(timeSent);
    } else if (timeSent.year == now.year &&
        timeSent.month == now.month &&
        timeSent.day == now.day - 1) {
      formattedDate = 'Kemarin';
    } else {
      formattedDate = DateFormat('dd/MM/yyyy').format(timeSent);
    }

    return formattedDate;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Group>>(
                  stream: ref.watch(chatControllerProvider).chatGroups(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }

                    // urutkan list berdasarkan waktu terkirim, pesan terbaru di atas
                    snapshot.data!
                        .sort((a, b) => b.timeSent.compareTo(a.timeSent));

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var groupData = snapshot.data![index];

                        // mengurutkan waktu pesan terkahir
                        String formattedDate =
                            getLastMessageFormattedDate(groupData.timeSent);

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  MobileChatScreen.routeName,
                                  arguments: {
                                    'user': UserModel(
                                      name: '',
                                      uid: '',
                                      profilePic: '',
                                      phoneNumber: '',
                                      isOnline: false,
                                      groupId: [],
                                    ),
                                    'group': Group(
                                      groupId: groupData.groupId,
                                      name: groupData.name,
                                      groupPic: groupData.groupPic,
                                      lastMessage: '',
                                      membersUid: [],
                                      senderId: '',
                                      timeSent: DateTime.now(),
                                    ),
                                    'isGroupChat': true,
                                    'nameContact': '',
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ListTile(
                                  textColor: blackColor,
                                  title: Text(
                                    groupData.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Text(
                                      groupData.lastMessage,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      groupData.groupPic,
                                    ),
                                    radius: 30,
                                  ),
                                  trailing: Text(
                                    formattedDate,
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
