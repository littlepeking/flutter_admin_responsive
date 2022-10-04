/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_edit_widget_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enhantec_ui_framework/base/eh_editable_widget.dart';

class EHFormDivider extends EHEditableWidget<EHFormDividerController> {
  EHFormDivider({
    controller,
  }) : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          decoration: BoxDecoration(
              color: EHThemeHelper.isDarkMode.value
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
  EHFormDividerController({double width = 0.0}) : super(width: width);

  @override
  validateWidget() async {
    return Future.value(true);
  }
}
