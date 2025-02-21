import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../video/views/video_view.dart';
import '../../audio/views/audio_view.dart';
import '../../more/views/more_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return const VideoView();
          case 1:
            return const AudioView();
          case 2:
            return MoreView();
          default:
            return const VideoView();
        }
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (index) => controller.changePage(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audio_file),
            label: 'Audio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      )),
    );
  }
}
