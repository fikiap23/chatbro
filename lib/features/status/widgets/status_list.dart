import 'package:chatbro/models/status_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StatusList extends StatelessWidget {
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

  final List<Status> list = [
    Status(
      uid: '1',
      username: 'Budi',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile1.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile1.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
    Status(
      uid: '2',
      username: 'Siti',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile2.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile2.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
    Status(
      uid: '3',
      username: 'Ahmad',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile1.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile1.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
    Status(
      uid: '4',
      username: 'Dewi',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile2.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile2.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
    Status(
      uid: '5',
      username: 'Agus',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile2.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile2.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
    Status(
      uid: '6',
      username: 'Yuli',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile2.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile2.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
    Status(
      uid: '7',
      username: 'Eko',
      phoneNumber: '',
      photoUrl: ['assets/images/profile_photos/profile2.png'],
      createdAt: DateTime.now(),
      profilePic: 'assets/images/profile_photos/profile2.png',
      statusId: '',
      whoCanSee: [],
      caption: 'Ini adalah caption pertama',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        String formattedDate = formatDate(list[index].createdAt);
        return ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage:
                NetworkImage("https://picsum.photos/id/23$index/200/300"),
          ),
          title: Text(list[index].username),
          subtitle: Text(formattedDate),
        );
      },
    );
  }
}
