import 'package:flutter/material.dart';

class CallLogScreen extends StatelessWidget {
  const CallLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Call Log',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildCallLogItem(
            'User 1',
            'Incoming',
            'Yesterday, 11:30 PM',
            '2m 30s',
          ),
          const SizedBox(height: 8),
          _buildCallLogItem(
            'User 2',
            'Outgoing',
            'Yesterday, 10:45 PM',
            '1m 15s',
          ),
          const SizedBox(height: 8),
          _buildCallLogItem(
            'User 3',
            'Incoming',
            'Yesterday, 10:00 PM',
            '3m 45s',
          ),
          const SizedBox(height: 8),
          _buildCallLogItem(
            'User 4',
            'Missed',
            'Yesterday, 9:15 PM',
            '',
          ),
        ],
      ),
    );
  }

  Widget _buildCallLogItem(
      String name, String type, String date, String duration) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150x150?text=$name'),
              radius: 25,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$type call • $date',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        Text(
          duration,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
