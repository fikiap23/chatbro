import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

abstract class AbstractGroup {
  void createGroup(
    BuildContext context,
    String name,
    File profilePic,
    List<Contact> selectedContact,
  );
}
