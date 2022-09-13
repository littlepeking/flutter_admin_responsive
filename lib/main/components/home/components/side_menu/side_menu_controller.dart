import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/workbench/workbench_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wms_module/wms_module_controller.dart';
import 'package:eh_flutter_framework/main/controllers/global_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenuController extends EHPanelController {
  static SideMenuController instance = Get.find<SideMenuController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrganizationModel defaultOrgModel =
      OrganizationModel(id: '-1', name: '<Select Org>');

  late Rx<OrganizationModel> selectedOrgModel = Rx(defaultOrgModel);

  SideMenuController(EHPanelController? parentController)
      : super(parentController);

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  reset() {
    selectedOrgModel.value = defaultOrgModel;
  }

  void toggleDrawer() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  EHTreeController getSideMenuController(SystemModule system) {
    switch (system) {
      case SystemModule.wms:
        return Get.find<WmsModuleController>().sideMenuTreeController;
      case SystemModule.tms:
        return Get.find<TmsModuleController>().sideMenuTreeController;
      case SystemModule.system:
        return Get.find<SystemModuleController>().sideMenuTreeController;
      case SystemModule.Workbench:
        return Get.find<WorkbenchModuleController>().sideMenuTreeController;
      default:
        throw Exception('no suitable menu found for' + system.toString());
    }
  }

  EHTreeView getSideBarTreeView() {
    EHTreeController controller =
        getSideMenuController(GlobalDataController.instance.system.value);

    return EHTreeView(
        key: GlobalKey(
            debugLabel: GlobalDataController.instance.system.value.name),
        controller: controller);
  }
}
