import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/youtube_save_controller.dart';
import '../widgets/download_options_dialog.dart';
import '../widgets/video_list_item.dart';

class YoutubeSaveView extends GetView<YoutubeSaveController> {
  const YoutubeSaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save from YouTube'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter YouTube URL or title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Placeholder for video list
                itemBuilder: (context, index) {
                  return VideoListItem(
                    title: 'Video Title',
                    channel: 'Channel Name',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DownloadOptionsDialog(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
