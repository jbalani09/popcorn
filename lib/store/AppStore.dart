import 'package:get/get.dart';


class AppStore {
  var isLoading = false.obs;

  var pageIndex = 1.obs;

  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
