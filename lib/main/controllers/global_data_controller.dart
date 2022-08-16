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

  static Rx<bool> localeChangeTrigger = true.obs;

  static changeLocale() {
    localeChangeTrigger.value = !localeChangeTrigger.value;
  }

  static String tr(String text) {
    //using print to cheat obx to let it rerender widget.
    print(localeChangeTrigger.value);
    return text.tr;
  }
}
