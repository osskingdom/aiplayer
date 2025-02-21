import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class YoutubeSaveController extends GetxController {
  final yt = YoutubeExplode();
  final dio = Dio();
  
  final isLoading = false.obs;
  final searchResults = <Video>[].obs;
  final searchQuery = ''.obs;

  Future<void> searchVideos(String query) async {
    try {
      isLoading.value = true;
      final search = await yt.search.search(query);
      searchResults.assignAll(search);
    } catch (e) {
      Get.snackbar('Error', 'Failed to search videos: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> downloadVideo(Video video, String quality, String type) async {
    try {
      // Check storage permission
      if (!await _checkStoragePermission()) {
        Get.snackbar('Permission Required', 'Please grant storage permission');
        return;
      }

      // Get download directory
      final dir = await getExternalStorageDirectory();
      if (dir == null) {
        throw Exception('Could not access storage');
      }

      // Get stream info
      final manifest = await yt.videos.streamsClient.getManifest(video.id);
      final streamInfo = type == 'Video' 
          ? manifest.muxed.withHighestBitrate()
          : manifest.audioOnly.withHighestBitrate();

      // Download file
      // Create type-specific directory if it doesn't exist
      final typeDir = Directory('${dir.path}/${type == 'Video' ? 'videos' : 'audios'}');
      if (!typeDir.existsSync()) {
        typeDir.createSync(recursive: true);
      }
      
      final savePath = '${typeDir.path}/${video.title}.${type == 'Video' ? 'mp4' : 'mp3'}';
      await dio.download(streamInfo.url.toString(), savePath);

      Get.snackbar('Success', 'Download completed: ${video.title}');
    } catch (e) {
      Get.snackbar('Error', 'Failed to download video: $e');
    }
  }

  Future<bool> _checkStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  @override
  void onClose() {
    yt.close();
    super.onClose();
  }
}
