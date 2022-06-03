import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_node.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
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

  static TreeController getSideMenuController(SystemModule system) {
    switch (system) {
      case SystemModule.wms:
        return Get.find<WmsPanelController>().sideMenuTreeController;
      case SystemModule.tms:
        return Get.find<TmsPanelController>().sideMenuTreeController;
      case SystemModule.system:
        return Get.find<SystemModuleController>().sideMenuTreeController;
      case SystemModule.notification:
        return Get.find<TaskPanelController>().sideMenuTreeController;
      default:
        throw Exception('no suitable menu found for' + system.toString());
    }
  }

  static List<EHTreeNode> getMenu(SystemModule module) {
    switch (module) {
      case SystemModule.wms:
        return Get.find<WmsPanelController>().menu;
      case SystemModule.tms:
        return Get.find<TmsPanelController>().menu;
      case SystemModule.system:
        return Get.find<SystemModuleController>().menu;
      case SystemModule.notification:
        return Get.find<TaskPanelController>().menu;
      default:
        throw Exception('no suitable menu found for' + module.toString());
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
