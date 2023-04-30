import 'dart:io';
import 'package:chatbro/models/group.dart';
import 'package:chatbro/models/message.dart';

import 'package:chatbro/common/enums/message_enum.dart';
import 'package:chatbro/models/chat_contact.dart';
import 'package:flutter/material.dart';

abstract class AbstractChat {
  Stream<List<ChatContact>> getChatContacts();
  Stream<List<Group>> chatGroups();
  Stream<List<Message>> chatStream(String recieverUserId);
  Stream<List<Message>> groupChatStream(String groupId);
  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
    bool isGroupChat,
  );
  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
    bool isGroupChat,
  );
  void sendGIFMessage(
    BuildContext context,
    String gifUrl,
    String recieverUserId,
    bool isGroupChat,
  );
  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  );
}
