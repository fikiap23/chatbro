import 'dart:io';
import 'dart:math';
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

  Color randomColor() {
    final Random random = Random();
    final int r = random.nextInt(256);
    final int g = random.nextInt(256);
    final int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  final TextEditingController _captionController = TextEditingController();

  void addStatus(WidgetRef ref, BuildContext context, String caption) {
    ref.read(statusControllerProvider).addStatus(file, context, caption);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: file != null
            ? Stack(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: Image.file(file!),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        // Aksi untuk menutup kontainer
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 50.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 65, 60, 60)
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: _captionController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Caption',
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                color: randomColor(),
                child: Stack(
                  children: [
                    Positioned(
                      top: 12.0,
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          // Aksi untuk menutup kontainer
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Center(
                      child: TextField(
                        controller: _captionController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Ketik status',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String caption = _captionController.text;
          addStatus(ref, context, caption);
        },
        backgroundColor: Coloors.greenDark,
        child: const Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}
