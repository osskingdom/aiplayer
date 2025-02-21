import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class YoutubeSaveController extends GetxController {
  final yt = YoutubeExplode();
  final dio = Dio();
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  
  final isLoading = false.obs;
  final downloadProgress = 0.0.obs;
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
      await dio.download(
        streamInfo.url.toString(), 
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = received / total;
            _showProgressNotification(video.title, downloadProgress.value);
          }
        },
      );

      downloadProgress.value = 0.0;
      _showDownloadCompleteNotification(video.title);
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

  Future<void> _showProgressNotification(String title, double progress) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'download_channel', 
        'Downloads',
        channelDescription: 'Download progress notifications',
        importance: Importance.low,
        priority: Priority.low,
        showProgress: true,
        maxProgress: 100,
        progress: (progress * 100).toInt(),
        onlyAlertOnce: true,
      );

    final NotificationDetails platformChannelSpecifics = 
      NotificationDetails(android: androidPlatformChannelSpecifics);

    await notificationsPlugin.show(
      0,
      'Downloading: $title',
      '${(progress * 100).toStringAsFixed(1)}% complete',
      platformChannelSpecifics,
    );
  }

  Future<void> _showDownloadCompleteNotification(String title) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'download_channel', 
        'Downloads',
        channelDescription: 'Download progress notifications',
        importance: Importance.high,
        priority: Priority.high,
      );

    final NotificationDetails platformChannelSpecifics = 
      NotificationDetails(android: androidPlatformChannelSpecifics);

    await notificationsPlugin.show(
      1,
      'Download Complete',
      'Downloaded: $title',
      platformChannelSpecifics,
    );
  }
}
