import 'package:get/get.dart';
import '../controllers/youtube_save_controller.dart';

class YoutubeSaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeSaveController>(
      () => YoutubeSaveController(),
    );
  }
}
