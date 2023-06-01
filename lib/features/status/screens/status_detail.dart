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
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: widget.status.photoUrl[i],
        imageFit: BoxFit.fitWidth,
        controller: storyController,
        caption: widget.status.captions[i],
      ));
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
          storyItems: [
            StoryItem.text(
              title:
                  "I guess you'd love to see more of our food. That's great.",
              backgroundColor: Colors.blue,
            ),
            StoryItem.text(
              title: "Nice!\n\nTap to continue.",
              backgroundColor: Colors.red,
              textStyle: TextStyle(
                fontFamily: 'Dancing',
                fontSize: 40,
              ),
            ),
            StoryItem.pageImage(
              url:
                  "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
              caption: "Still sampling",
              controller: storyController,
            ),
            StoryItem.pageImage(
                url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
                caption: "Working with gifs",
                controller: storyController),
            StoryItem.pageImage(
              url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
              caption: "Hello, from the other side",
              controller: storyController,
            ),
            StoryItem.pageImage(
              url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
              caption: "Hello, from the other side2",
              controller: storyController,
            ),
          ],
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
