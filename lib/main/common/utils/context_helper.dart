import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/system_module_controller.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/wms_module/wms_module_controller.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/workbench_module/workbench_module_controller.dart';
import 'package:get/get.dart';

class ContextHelper {
  static void resetAllModuleTabs() {
    if (Get.isRegistered<SystemModuleController>())
      resetTab(Get.find<SystemModuleController>().moduleTabViewController);
    if (Get.isRegistered<WmsModuleController>())
      resetTab(Get.find<WmsModuleController>().moduleTabViewController);
    if (Get.isRegistered<TmsModuleController>())
      resetTab(Get.find<TmsModuleController>().moduleTabViewController);
    if (Get.isRegistered<WorkbenchModuleController>())
      resetTab(Get.find<WorkbenchModuleController>().moduleTabViewController);
  }

  static void resetTab(EHTabsViewController? c) {
    if (c != null) c.reset();
  }
}
