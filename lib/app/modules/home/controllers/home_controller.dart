import 'package:get/get.dart';

class HomeController extends GetxController {
  // This controller manages the state of the home module
  // It holds the current index for navigation
  final RxInt currentIndex = 0.obs;

  // Changes the current page index
  void changePage(int index) {
    currentIndex.value = index;
  }
}
