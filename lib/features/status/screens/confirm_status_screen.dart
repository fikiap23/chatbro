import 'dart:io';
import 'package:chatbro/features/status/controller/status_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/coloors.dart';

class ConfirmStatusScreen extends ConsumerWidget {
  static const String routeName = '/confirm-status-screen';
  final File? file;

  ConfirmStatusScreen({
    Key? key,
    this.file,
  }) : super(key: key);

  final TextEditingController _captionController = TextEditingController();

  void addStatus(WidgetRef ref, BuildContext context, String caption) {
    ref.read(statusControllerProvider).addStatus(file, context, caption);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: file != null
            ? AspectRatio(
                aspectRatio: 9 / 16,
                child: Image.file(file!),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String caption = _captionController.text;
          addStatus(ref, context, caption);
        },
        backgroundColor: Coloors.greenDark,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        color: Colors.white,
        child: TextField(
          controller: _captionController,
          decoration: const InputDecoration(
            hintText: 'Caption',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
