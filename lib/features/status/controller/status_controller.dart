import 'dart:io';
import 'package:chatbro/features/auth/controller/auth_controller.dart';
import 'package:chatbro/features/status/repository/status_repository.dart';
import 'package:chatbro/models/status_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final statusControllerProvider = Provider((ref) {
  final statusRepository = ref.read(statusRepositoryProvider);
  return StatusController(
    statusRepository: statusRepository,
    ref: ref,
  );
});

class StatusController {
  final StatusRepository statusRepository;
  final ProviderRef ref;
  StatusController({
    required this.statusRepository,
    required this.ref,
  });

  void addStatus(File? file, BuildContext context, String caption) {
    ref.watch(userDataAuthProvider).whenData((value) {
      statusRepository.uploadStatus(
        username: value!.name,
        profilePic: value.profilePic,
        phoneNumber: value.phoneNumber,
        statusImage: file,
        context: context,
        caption: caption,
      );
    });
  }

  Stream<List<Status>> getStatusStream(BuildContext context) {
    return statusRepository.getStatusStream(context);
  }
}
