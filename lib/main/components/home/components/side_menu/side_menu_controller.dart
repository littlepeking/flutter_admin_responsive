import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/task_menu.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tmsPanel/tms_menu.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_menu.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:get/get.dart';

class SideMenuController extends GetxController {
  static SideMenuController instance = Get.find<SideMenuController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void toggleDrawer() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  TreeController treeController = new TreeController(allNodesExpanded: false);

  static List<EHTreeNode> getMenu(System system) {
    SideMenuController.instance.treeController.collapseAll();

    switch (system) {
      case System.wms:
        return wmsMenu;
      case System.tms:
        return tmsMenu;
      case System.notification:
        return taskMenu;
      default:
        throw Exception('no suitable menu found for' + system.toString());
    }
  }
}
