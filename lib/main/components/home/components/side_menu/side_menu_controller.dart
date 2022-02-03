import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/taskPanel/task_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tmsPanel/tms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel_controller.dart';
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

  static TreeController getSideMenuController(System system) {
    switch (system) {
      case System.wms:
        return Get.find<WmsPanelController>().sideMenuTreeController;
      case System.tms:
        return Get.find<TmsPanelController>().sideMenuTreeController;
      case System.notification:
        return Get.find<TaskPanelController>().sideMenuTreeController;
      default:
        throw Exception('no suitable menu found for' + system.toString());
    }
  }

  static List<EHTreeNode> getMenu(System system) {
    switch (system) {
      case System.wms:
        return Get.find<WmsPanelController>().menu;
      case System.tms:
        return Get.find<TmsPanelController>().menu;
      case System.notification:
        return Get.find<TaskPanelController>().menu;
      default:
        throw Exception('no suitable menu found for' + system.toString());
    }
  }

  static TreeView getSideBarTreeView() {
    return TreeView(
        key: GlobalKey(
            debugLabel: GlobalDataController.instance.system.value.name),
        iconSize: 20,
        indent: 10,
        treeController:
            getSideMenuController(GlobalDataController.instance.system.value),
        nodes: getMenu(GlobalDataController.instance.system.value));
  }
}
