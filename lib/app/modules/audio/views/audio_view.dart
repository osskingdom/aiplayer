import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/folder_list_item.dart';
import '../controllers/audio_controller.dart';

class AudioView extends GetView<AudioController> {
  const AudioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Folders'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Audio Folders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Placeholder for actual folder count
                itemBuilder: (context, index) {
                  return FolderListItem(
                    title: 'Audio Folder ${index + 1}',
                    onTap: () {
                      // TODO: Handle folder tap
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
