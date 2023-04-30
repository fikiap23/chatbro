import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AbstractCall {
  Stream<DocumentSnapshot> get callStream;

  void makeCall(BuildContext context, String receiverName, String receiverUid,
      String receiverProfilePic, bool isGroupChat);

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  );
}
