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
                    decoration: const InputDecoration(
                      hintText: 'Enter YouTube URL or title',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => controller.searchQuery.value = value,
                    onSubmitted: (value) => controller.searchVideos(value),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.searchVideos(controller.searchQuery.value),
                  child: const Text('Search'),
                )),
              ],
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final video = controller.searchResults[index];
                    return VideoListItem(
                      title: video.title,
                      channel: video.author,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DownloadOptionsDialog(
                            onDownload: (type, quality) {
                              controller.downloadVideo(video, quality, type);
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
