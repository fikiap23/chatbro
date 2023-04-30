import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

abstract class AbstractContact {
  void selectContact(Contact selectedContact, BuildContext context);
}
