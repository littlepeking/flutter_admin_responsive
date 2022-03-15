import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/eh_editable_widget.dart';

class EHFormDivider extends EHEditableWidget<EHFormDividerController> {
  EHFormDivider({
    controller,
  }) : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: ThemeController.instance.isDarkMode.value
                  ? Colors.grey[800]
                  : Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: controller.width == 0
              ? null
              : EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          height: controller.width,
          width: double.infinity,
        ));
  }
}

class EHFormDividerController extends EHEditableWidgetController {
  EHFormDividerController({width = 0}) : super(width: width);

  @override
  validateWidget() {
    return true;
  }
}
