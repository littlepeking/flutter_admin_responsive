import 'package:get/get.dart';

class EHLocaleHelper {
  static Rx<bool> localeChangeTrigger = true.obs;

  // static changeLocale() {
  //   localeChangeTrigger.value = !localeChangeTrigger.value;
  // }

  static String tr(String text) {
    //using print to cheat obx to let it rerender widget.
    print(localeChangeTrigger.value);
    return text.tr;
  }
}
