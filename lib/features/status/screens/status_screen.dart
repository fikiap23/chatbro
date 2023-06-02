import 'dart:io';

import 'package:chatbro/common/utils/coloors.dart';
import 'package:chatbro/common/utils/utils.dart';
import 'package:chatbro/features/status/screens/confirm_status_screen.dart';
import 'package:chatbro/features/status/widgets/status_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusScreen extends ConsumerWidget {
  static const String routeName = '/status-screen';
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.grey,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.person, color: Colors.white, size: 40),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 16),
                      ),
                    ),
                  ],
                ),
              ),
              title: const Text("My Status"),
              subtitle: const Text("Tap to add status update"),
              trailing: const Icon(Icons.more_horiz),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text('Recent updates'),
            ),
            StatusList(),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: backgroundColor,
              heroTag: "tombolTambah",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ConfirmStatusScreen.routeName,
                );
              },
              tooltip: 'Tambah',
              child: const Icon(
                Icons.edit,
                color: Colors.black87,
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: "camera",
              onPressed: () async {
                File? pickedImage = await pickImageFromGallery(context);
                if (pickedImage != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(
                    context,
                    ConfirmStatusScreen.routeName,
                    arguments: pickedImage,
                  );
                }
              },
              tooltip: 'Camera',
              child: const Icon(
                Icons.camera_alt,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
