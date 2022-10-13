import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_module_controller.dart';
import 'package:get/get.dart';

abstract class EHModuleWidget<T extends EHModuleController> extends GetView<T> {
  EHModuleWidget({super.key});
}
