import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/video_controller.dart';

class VideoView extends GetView<VideoController> {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Folders'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Video Folders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Placeholder for actual folder count
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.folder),
                      title: Text('Video Folder ${index + 1}'),
                      onTap: () {
                        // TODO: Handle folder tap
                      },
                    ),
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
