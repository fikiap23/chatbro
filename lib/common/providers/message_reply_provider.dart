import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatbro/common/enums/message_enum.dart';

// Class MessageReply berisi informasi tentang pesan yang di-reply,
// termasuk pesan itu sendiri, status pengirim, dan jenis pesan.
class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(this.message, this.isMe, this.messageEnum);
}

// StateProvider untuk menyimpan informasi tentang pesan yang di-reply.
final messageReplyProvider = StateProvider<MessageReply?>((ref) => null);
