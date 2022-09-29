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

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_edit_widget_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_editable_widget.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHCustomFormWidget<T extends EHModel>
    extends EHEditableWidget<EHCustomFormWidgetController<T>> {
  EHCustomFormWidget({
    required EHCustomFormWidgetController<T> controller,
  }) : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    //Remove obx if widget does not use observable object value and we can cheat obx to force refresh by utilizing print() function =)
    //return Obx(() {
    if (controller._child == null) {
      Widget widget = controller.widgetBuilder(
          controller.key, controller.focusNode, controller.rxModel);
      controller._child = widget;
      //print(controller.rxModel!.toJson());
    }
    return controller._child!;
    //});
  }
}

class EHCustomFormWidgetController<T extends EHModel>
    extends EHEditableWidgetController<T> {
  EHCustomFormWidgetController({required this.widgetBuilder});

  Widget? _child;

  Widget Function(Key? key, FocusNode? focusNode, Rx<T>? rxModel) widgetBuilder;

  @override
  validateWidget() async {
    if (_child is EHValidationWidget) {
      return await (_child as EHValidationWidget).validate();
    } else
      return Future.value(true);
  }
}

abstract class EHValidationWidget extends StatelessWidget {
  Future<bool> validate();
}
