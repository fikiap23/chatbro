// Import dependencies
import 'package:chatbro/features/select_contacts/abstraction/abstract_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatbro/features/select_contacts/repository/contact_repository.dart';

// Provider untuk mendapatkan semua kontak
final getAllContactsProvider = FutureProvider(
  (ref) {
    final contactsRepository = ref.watch(contactsRepositoryProvider);
    return contactsRepository.getAllContacts();
  },
);

// Provider untuk mendapatkan kontak yang telah dipilih
final getContactsProvider = FutureProvider((ref) {
  final contactRepository = ref.watch(contactsRepositoryProvider);
  return contactRepository.getContacts();
});

// Provider untuk ContactController
final contactControllerProvider = Provider((ref) {
  final contactRepository = ref.watch(contactsRepositoryProvider);
  return ContactController(
    ref: ref,
    contactRepository: contactRepository,
  );
});

// Kelas ContactController yang mengimplementasikan AbstractContact
class ContactController implements AbstractContact {
  final ProviderRef ref;
  final ContactRepository contactRepository;

// Konstruktor ContactController
  ContactController({
    required this.ref,
    required this.contactRepository,
  });

// Metode untuk memilih kontak
  @override
  void selectContact(Contact selectedContact, BuildContext context) {
    contactRepository.selectContact(selectedContact, context);
  }
}
