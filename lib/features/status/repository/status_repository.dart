import 'dart:io';

import 'package:chatbro/common/repositories/common_firebase_storage_repository.dart';
import 'package:chatbro/common/utils/utils.dart';
import 'package:chatbro/models/status_model.dart';
import 'package:chatbro/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class StatusRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;
  StatusRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadStatus({
    required String username,
    required String profilePic,
    required String phoneNumber,
    String? caption,
    File? statusImage,
    File? statusVideo,
    required BuildContext context,
  }) async {
    try {
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;
      String fileUrl;

      if (statusImage != null) {
        fileUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              '/status/$statusId$uid',
              statusImage,
            );
      } else {
        fileUrl = "";
      }

      caption ??= "";

      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }

      List<String> uidWhoCanSee = [];

      for (int i = 0; i < contacts.length; i++) {
        var userDataFirebase = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo:
                  "+${contacts[i].phones[0].number.replaceAll(RegExp(r'[^0-9]'), '')}",
            )
            .get();

        if (userDataFirebase.docs.isNotEmpty) {
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          uidWhoCanSee.add(userData.uid);
        }
      }

      List<String> statusFileUrls = [];
      var statusesSnapshot = await firestore
          .collection('status')
          .where(
            'uid',
            isEqualTo: auth.currentUser!.uid,
          )
          .get();

      if (statusesSnapshot.docs.isNotEmpty) {
        Status status = Status.fromMap(statusesSnapshot.docs[0].data());
        statusFileUrls = status.photoUrl;
        statusFileUrls.add(fileUrl);
        await firestore
            .collection('status')
            .doc(statusesSnapshot.docs[0].id)
            .update({
          'photoUrl': statusFileUrls,
          'captions': FieldValue.arrayUnion([caption]), // Update captions array
        });
        return;
      } else {
        statusFileUrls = [fileUrl];
      }

      Status status = Status(
        uid: uid,
        username: username,
        phoneNumber: phoneNumber,
        photoUrl: statusFileUrls,
        createdAt: DateTime.now(),
        profilePic: profilePic,
        statusId: statusId,
        whoCanSee: uidWhoCanSee,
        captions: [caption],
      );

      await firestore.collection('status').doc(statusId).set(status.toMap());
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  Stream<List<Status>> getStatusStream(BuildContext context) async* {
    try {
      Map<String, String> phoneNumberToUsername = {};

      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
        phoneNumberToUsername = {
          for (var contact in contacts)
            "+${contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '')}":
                contact.displayName
        };
      }

      var query = firestore.collection('status').where(
            'createdAt',
            isGreaterThan: DateTime.now()
                .subtract(const Duration(hours: 24))
                .millisecondsSinceEpoch,
          );

      await for (var statusesSnapshot in query.snapshots()) {
        List<Status> statusData = [];
        for (var tempData in statusesSnapshot.docs) {
          Status tempStatus = Status.fromMap(tempData.data());
          if (tempStatus.whoCanSee.contains(auth.currentUser!.uid)) {
            String phoneNumber = tempStatus.phoneNumber;
            String originalUsername =
                phoneNumberToUsername[phoneNumber] ?? phoneNumber;
            String username = (tempStatus.uid == auth.currentUser!.uid)
                ? 'Saya'
                : originalUsername;
            Status usernameStatus = Status(
              uid: tempStatus.uid,
              username: username,
              phoneNumber: tempStatus.phoneNumber,
              photoUrl: tempStatus.photoUrl,
              createdAt: tempStatus.createdAt,
              profilePic: tempStatus.profilePic,
              statusId: tempStatus.statusId,
              whoCanSee: tempStatus.whoCanSee,
              captions: tempStatus.captions,
            );
            statusData.add(usernameStatus);
          }
        }
        yield statusData;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      showSnackBar(context: context, content: e.toString());
      yield [];
    }
  }
}
