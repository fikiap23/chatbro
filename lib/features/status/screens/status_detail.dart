import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbro/models/status_model.dart';
import 'package:flutter/material.dart';
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
  StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: widget.status.photoUrl[i],
        controller: controller,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.status.caption);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          StoryView(
            storyItems: storyItems,
            controller: controller,
            onComplete: () {
              Navigator.pop(context);
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
          ),
          Positioned(
            top: 60,
            left: 10,
            child: Row(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.status.profilePic,
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8.0),
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
                    const SizedBox(height: 4.0),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 1.0,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Text(
              widget.status.caption,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
