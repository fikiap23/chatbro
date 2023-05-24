import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:chatbro/common/enums/message_enum.dart';
import 'package:chatbro/common/providers/message_reply_provider.dart';
import 'package:chatbro/common/widgets/loader.dart';
import 'package:chatbro/features/chat/controller/chat_controller.dart';
import 'package:chatbro/features/chat/widgets/my_message_card.dart';
import 'package:chatbro/features/chat/widgets/sender_message_card.dart';
import 'package:chatbro/models/message.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  final String name;
  final bool isGroupChat;
  const ChatList({
    Key? key,
    required this.recieverUserId,
    required this.name,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  String displayTextDateContainer(Message messageData) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day)
        .toLocal(); // Konversi ke zona waktu lokal
    final yesterday =
        today.subtract(const Duration(days: 1)); // Tanggal kemarin
    final weekAgo = today
        .subtract(const Duration(days: 7))
        .toLocal(); // Konversi ke zona waktu lokal
    final timeSent =
        messageData.timeSent.toLocal(); // Konversi ke zona waktu lokal

    if (timeSent.year == now.year &&
        timeSent.month == now.month &&
        timeSent.day == now.day) {
      return "Hari Ini";
    } else if (timeSent.year == yesterday.year &&
        timeSent.month == yesterday.month &&
        timeSent.day == yesterday.day) {
      return "Kemarin";
    } else if (timeSent.isAfter(weekAgo)) {
      return DateFormat('EEEE', 'id').format(timeSent);
    } else {
      return DateFormat('d MMM y', 'id').format(timeSent);
    }
  }

  void onMessageSwipe(
    String message,
    bool isMe,
    MessageEnum messageEnum,
  ) {
    ref.read(messageReplyProvider.state).update(
          (state) => MessageReply(
            message,
            isMe,
            messageEnum,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return StreamBuilder<List<Message>>(
        stream: widget.isGroupChat
            ? ref
                .read(chatControllerProvider)
                .groupChatStream(widget.recieverUserId)
            : ref
                .read(chatControllerProvider)
                .chatStream(widget.recieverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          String? lastDisplayedDate;

          return ListView.builder(
            controller: messageController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];

              String timeSent = DateFormat.Hm().format(messageData.timeSent);
              String containerText = displayTextDateContainer(messageData);

              // cek apakah tanggal harus ditampilkan
              final bool shouldDisplayContainer = lastDisplayedDate == null ||
                  lastDisplayedDate != containerText;

              // update tanggal terakhir
              lastDisplayedDate = containerText;

              if (!messageData.isSeen &&
                  messageData.recieverid ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                      context,
                      widget.recieverUserId,
                      messageData.messageId,
                    );
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return Column(
                  children: [
                    if (shouldDisplayContainer)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          containerText,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    MyMessageCard(
                      message: messageData.text,
                      date: timeSent,
                      type: messageData.type,
                      repliedText: messageData.repliedMessage,
                      username: messageData.repliedTo,
                      repliedMessageType: messageData.repliedMessageType,
                      onLeftSwipe: () => onMessageSwipe(
                        messageData.text,
                        true,
                        messageData.type,
                      ),
                      isSeen: messageData.isSeen,
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  if (shouldDisplayContainer)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        containerText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  SenderMessageCard(
                    name: messageData.senderId,
                    isGroup: widget.isGroupChat,
                    message: messageData.text,
                    date: timeSent,
                    type: messageData.type,
                    username: messageData.repliedTo,
                    repliedMessageType: messageData.repliedMessageType,
                    onRightSwipe: () => onMessageSwipe(
                      messageData.text,
                      false,
                      messageData.type,
                    ),
                    repliedText: messageData.repliedMessage,
                  ),
                ],
              );
            },
          );
        });
  }
}
