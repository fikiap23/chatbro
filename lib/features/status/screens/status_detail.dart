import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbro/models/status_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:story_view/story_view.dart';

class StatusDetailScreen extends StatefulWidget {
  static const String routeName = '/status-detail-screen';
  final Status status;

  const StatusDetailScreen({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  _StatusDetailScreenState createState() => _StatusDetailScreenState();
}

class _StatusDetailScreenState extends State<StatusDetailScreen> {
  final storyController = StoryController();
  List<StoryItem> storyItems = [];
  Color randomColor() {
    final Random random = Random();
    final int r = random.nextInt(256);
    final int g = random.nextInt(256);
    final int b = random.nextInt(256);
    return Color.fromARGB(255, r, g, b);
  }

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
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    final random = Random();
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      if (widget.status.photoUrl[i].isNotEmpty ||
          widget.status.photoUrl[i] != "") {
        storyItems.add(
          StoryItem.pageImage(
            url: widget.status.photoUrl[i],
            imageFit: BoxFit.fitWidth,
            controller: storyController,
            caption: widget.status.captions[i],
          ),
        );
      } else {
        storyItems.add(
          StoryItem.text(
            title: widget.status.captions[i],
            textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            backgroundColor: randomColor(),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        StoryView(
          controller: storyController,
          onComplete: () {
            Navigator.pop(context);
          },
          onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
          storyItems: storyItems,
          onStoryShow: (s) {},
          progressPosition: ProgressPosition.top,
          repeat: false,
        ),
        Positioned(
          top: 50,
          left: 10,
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.status.profilePic,
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.status.username,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    formatDate(widget.status.createdAt),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
