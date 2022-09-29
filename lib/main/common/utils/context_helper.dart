import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_frontend_project/main/common/constants/constants.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/wms_module/wms_module_controller.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/workbench_module/workbench_module_controller.dart';
import 'package:get/get.dart';

class ContextHelper {
  static Rx<SystemModule> currentModule = SystemModule.workbench.obs;

  static void resetAllModuleTabs() {
    if (Get.isRegistered<SystemModuleController>())
      resetTab(Get.find<SystemModuleController>().tabViewController);
    if (Get.isRegistered<WmsModuleController>())
      resetTab(Get.find<WmsModuleController>().tabViewController);
    if (Get.isRegistered<TmsModuleController>())
      resetTab(Get.find<TmsModuleController>().tabViewController);
    if (Get.isRegistered<WorkbenchModuleController>())
      resetTab(Get.find<WorkbenchModuleController>().tabViewController);
  }

  static void resetTab(EHTabsViewController? c) {
    if (c != null) c.reset();
  }
}
