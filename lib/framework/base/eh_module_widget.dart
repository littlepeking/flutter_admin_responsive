import 'package:enhantec_platform_ui/framework/base/eh_module_controller.dart';
import 'package:flutter/material.dart';

abstract class EHModuleWidget<T extends EHModuleController>
    extends StatelessWidget {
  final T controller;

  EHModuleWidget({super.key, required this.controller});
}
