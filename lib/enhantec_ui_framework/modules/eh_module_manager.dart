import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_module_widget.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/system_module.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/system_module_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:get/get.dart';

enum SystemNativeModule {
  SYSTEM,
}

class EHModuleManager {
  static Map<String, EHModuleWidget> systemModuleMap = {
    SystemNativeModule.SYSTEM.name: SystemModuleWidget(
        controller: Get.put(
      SystemModuleController(),
      permanent: true,
    ))
  };

  static registerModule(String moduleId, EHModuleWidget moduleWidget) {
    systemModuleMap.putIfAbsent(moduleId, () => moduleWidget);
    Get.put(moduleWidget.controller, permanent: true);
  }

  static void resetAllModuleTabs() {
    systemModuleMap.forEach((key, value) {
      resetTab(value.controller.moduleTabViewController);
    });
  }

  static void resetTab(EHTabsViewController? c) {
    if (c != null) c.reset();
  }
}
