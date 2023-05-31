import 'package:chatbro/common/widgets/loader.dart';
import 'package:chatbro/features/status/controller/status_controller.dart';
import 'package:chatbro/features/status/screens/status_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StatusList extends ConsumerWidget {
  StatusList({super.key});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: ref.read(statusControllerProvider).getStatus(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var statusData = snapshot.data![index];
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
                  backgroundImage: NetworkImage(
                    lastStatusPic,
                  ),
                ),
                title: Text(statusData.username),
                subtitle: Text(formattedDate),
              );
            },
          );
        });
  }
}