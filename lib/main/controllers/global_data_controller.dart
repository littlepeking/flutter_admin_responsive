import 'package:get/get.dart';

enum SystemModule {
  wms,
  tms,
  system,
  notification,
}

class GlobalDataController extends GetxController {
  static GlobalDataController instance = Get.find<GlobalDataController>();

  Rx<SystemModule> system = SystemModule.system.obs;
}
