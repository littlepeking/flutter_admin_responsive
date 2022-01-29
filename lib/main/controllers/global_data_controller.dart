import 'package:get/get.dart';

enum System {
  wms,
  tms,
  notification,
}

class GlobalDataController extends GetxController {
  static GlobalDataController instance = Get.find<GlobalDataController>();

  Rx<System> system = System.wms.obs;
}
