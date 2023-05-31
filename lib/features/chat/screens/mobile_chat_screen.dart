import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbro/features/chat/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatbro/common/utils/coloors.dart';
import 'package:chatbro/common/widgets/loader.dart';
import 'package:chatbro/features/auth/controller/auth_controller.dart';
import 'package:chatbro/features/call/controller/call_controller.dart';
import 'package:chatbro/features/call/screens/call_pickup_screen.dart';
import 'package:chatbro/features/chat/widgets/bottom_chat_field.dart';
import 'package:chatbro/features/chat/widgets/chat_list.dart';
import 'package:chatbro/models/group.dart';
import 'package:chatbro/models/user_model.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final UserModel user;
  final String nameContact;
  final Group group;
  final bool isGroupChat;

  const MobileChatScreen({
    Key? key,
    required this.user,
    required this.nameContact,
    required this.group,
    required this.isGroupChat,
  }) : super(key: key);

  void makeCall(WidgetRef ref, BuildContext context) {
    if (isGroupChat) {
      ref.read(callControllerProvider).makeCall(
            context,
            group.name,
            group.groupId,
            group.groupPic,
            isGroupChat,
          );
    } else {
      ref.read(callControllerProvider).makeCall(
            context,
            user.name,
            user.uid,
            user.profilePic,
            isGroupChat,
          );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                const Icon(Icons.arrow_back),
                Hero(
                  tag: 'profile',
                  child: Container(
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: isGroupChat
                            ? CachedNetworkImageProvider(group.groupPic)
                            : CachedNetworkImageProvider(user.profilePic),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: isGroupChat
              ? Text(group.name)
              : StreamBuilder<UserModel>(
                  stream:
                      ref.read(authControllerProvider).userDataById(user.uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    return Column(
                      children: [
                        InkWell(
                          child: Text(nameContact),
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProfileScreen.routeName, arguments: {
                              'user': user,
                              'nameContact': nameContact
                            });
                          },
                        ),
                        Text(
                          snapshot.data!.isOnline ? 'online' : 'offline',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    );
                  }),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () => makeCall(ref, context),
              icon: const Icon(Icons.video_call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: isGroupChat
                  ? ChatList(
                      name: group.name,
                      recieverUserId: group.groupId,
                      isGroupChat: isGroupChat,
                    )
                  : ChatList(
                      name: user.name,
                      recieverUserId: user.uid,
                      isGroupChat: isGroupChat,
                    ),
            ),
            isGroupChat
                ? BottomChatField(
                    recieverUserId: group.groupId,
                    isGroupChat: isGroupChat,
                  )
                : BottomChatField(
                    recieverUserId: user.uid,
                    isGroupChat: isGroupChat,
                  ),
          ],
        ),
      ),
    );
  }
}
