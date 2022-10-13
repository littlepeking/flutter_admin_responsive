import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_module_widget.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/system_module.dart';

enum SystemNativeModule {
  system,
}

class ModuleRegistry {
  static Map<String, EHModuleWidget> systemModuleMap = {
    SystemNativeModule.system.name: SystemModuleWidget(),
  };

  static registerModule(String moduleName, EHModuleWidget moduleWidget) {
    systemModuleMap.putIfAbsent(moduleName, () => moduleWidget);
  }
}
