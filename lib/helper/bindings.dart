import 'package:get/get.dart';
import 'package:popcorn/helper/reservation_controller.dart';
import '../screen/base_view/controller/animation_controller.dart';
import 'cart_controller.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ControllerAnimation());
    Get.put(ReservationController());
    Get.lazyPut(() => CardController());
    // Get.put(SavedController());
  }
}
