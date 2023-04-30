// Import library yang dibutuhkan
import 'dart:io';
import 'package:chatbro/features/group/abstraction/abstract_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chatbro/features/group/repository/group_repository.dart';

// Buat sebuah provider untuk GroupController
final groupControllerProvider = Provider((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);
  return GroupController(
    groupRepository: groupRepository,
    ref: ref,
  );
});

// Buat kelas GroupController yang mengimplementasikan interface AbstractGroup
class GroupController implements AbstractGroup {
  final GroupRepository groupRepository; // Repository untuk mengakses data grup
  final ProviderRef ref;

// Konstruktor untuk menginisialisasi groupRepository dan ref
  GroupController({
    required this.groupRepository,
    required this.ref,
  });

// Implementasikan fungsi createGroup() yang didefinisikan di dalam interface AbstractGroup
  @override
  void createGroup(BuildContext context, String name, File profilePic,
      List<Contact> selectedContact) {
// Panggil fungsi createGroup() dari groupRepository untuk membuat grup baru
    groupRepository.createGroup(context, name, profilePic, selectedContact);
  }
}
