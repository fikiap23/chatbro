import 'dart:developer';

import 'package:chatbro/common/widgets/show_alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatbro/common/utils/utils.dart';
import 'package:chatbro/models/user_model.dart';
import 'package:chatbro/features/chat/screens/mobile_chat_screen.dart';

final contactsRepositoryProvider = Provider(
  (ref) => ContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class ContactRepository {
  final FirebaseFirestore firestore;

  ContactRepository({
    required this.firestore,
  });

  Future<List<List<UserModel>>> getAllContacts() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        final allContactsInThePhone = await FlutterContacts.getContacts(
          withProperties: true,
        );

        // print(allContactsInThePhone.toString());
        // print(userCollection.toString());
        bool isContactFound = false;

        for (var contact in allContactsInThePhone) {
          // print(contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), ''));
          for (var firebaseContactData in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseContactData.data());
            if ("+${contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '')}" ==
                firebaseContact.phoneNumber) {
              firebaseContacts.add(UserModel(
                name: contact
                    .displayName, // Menggunakan displayName dari kontak ponsel
                uid: firebaseContact.uid,
                profilePic: firebaseContact.profilePic,
                isOnline: firebaseContact.isOnline,
                // lastSeen: firebaseContact.lastSeen,
                phoneNumber: firebaseContact.phoneNumber,
                groupId: firebaseContact.groupId,
              ));
              isContactFound = true;
              break;
            }
          }
          if (!isContactFound) {
            phoneContacts.add(
              UserModel(
                name: contact.displayName,
                uid: '',
                profilePic: '',
                isOnline: false,
                // lastSeen: 0,
                phoneNumber:
                    contact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), ''),
                groupId: [],
              ),
            );
          }

          isContactFound = false;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return [firebaseContacts, phoneContacts];
  }

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('users').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(RegExp(r'[^0-9]'), '');

        selectedPhoneNum = "+$selectedPhoneNum";
        // print(selectedPhoneNum);
        if (selectedPhoneNum == userData.phoneNumber) {
          // print(userData.groupId);
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(
            context,
            MobileChatScreen.routeName,
            arguments: {
              'name': userData.name,
              'uid': userData.uid,
              'isGroupChat': false,
              'profilePic': userData.profilePic,
            },
          );
        }
      }

      if (!isFound) {
        // ignore: use_build_context_synchronously
        showAlertDialog(
          context: context,
          message: 'This number does not exist on this app.',
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
