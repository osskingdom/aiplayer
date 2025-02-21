import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/youtube_save_controller.dart';

class YoutubeSaveView extends GetView<YoutubeSaveController> {
  const YoutubeSaveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save from YouTube'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'YouTube Save Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
