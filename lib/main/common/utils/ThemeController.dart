import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController instance = Get.find<ThemeController>();

  var isDarkMode = false.obs;
}
