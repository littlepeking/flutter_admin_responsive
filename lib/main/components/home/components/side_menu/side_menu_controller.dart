import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

class SideMenuController extends GetxController {
  static SideMenuController instance = Get.find<SideMenuController>();

  TreeController treeController = new TreeController();
}
