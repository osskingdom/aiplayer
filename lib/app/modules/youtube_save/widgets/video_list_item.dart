import 'package:flutter/material.dart';

class VideoListItem extends StatelessWidget {
  final String title;
  final String channel;
  final VoidCallback onTap;

  const VideoListItem({
    super.key,
    required this.title,
    required this.channel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.video_library),
      title: Text(title),
      subtitle: Text(channel),
      onTap: onTap,
    );
  }
}
