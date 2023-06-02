import 'dart:math';

import 'package:chatbro/common/widgets/loader.dart';
import 'package:chatbro/features/status/controller/status_controller.dart';
import 'package:chatbro/features/status/screens/status_detail.dart';
import 'package:chatbro/models/status_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StatusList extends ConsumerWidget {
  StatusList({Key? key}) : super(key: key);

  String formatDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

    String formattedDate;

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      formattedDate = "hari ini ${DateFormat('HH.mm').format(dateTime)}";
    } else if (dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day) {
      formattedDate = "kemarin ${DateFormat('HH.mm').format(dateTime)}";
    } else {
      formattedDate = DateFormat('dd/MM/yyyy HH.mm').format(dateTime);
    }

    return formattedDate;
  }

  Color randomColor() {
    final Random random = Random();
    final int r = random.nextInt(256);
    final int g = random.nextInt(256);
    final int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Status>>(
      stream: ref.read(statusControllerProvider).getStatusStream(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        List<Status>? statusList = snapshot.data;
        if (statusList == null || statusList.isEmpty) {
          return const Center(child: Text('No status available'));
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: statusList.length,
          itemBuilder: (BuildContext context, int index) {
            var statusData = statusList[index];
            var lastStatusPic =
                statusData.photoUrl[statusData.photoUrl.length - 1];
            String formattedDate = formatDate(statusData.createdAt);
            return ListTile(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  StatusDetailScreen.routeName,
                  arguments: statusData,
                );
              },
              leading: CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    lastStatusPic != "" ? NetworkImage(lastStatusPic) : null,
                backgroundColor: lastStatusPic != ""
                    ? null
                    : randomColor(), // Warna latar belakang jika backgroundImage null
                child: lastStatusPic != ""
                    ? null
                    : Text(
                        statusData.captions[statusData.captions.length - 1],
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
              ),
              title: Text(statusData.username),
              subtitle: Text(formattedDate),
            );
          },
        );
      },
    );
  }
}
