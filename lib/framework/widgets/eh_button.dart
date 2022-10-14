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

import 'package:enhantec_platform_ui/framework/base/eh_edit_widget_controller.dart';
import 'package:enhantec_platform_ui/framework/base/eh_stateless_widget.dart';
import 'package:flutter/material.dart';

class EHButton extends EHStatelessWidget<EHButtonController> {
  EHButton({Key? key, required EHButtonController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 28,
        child: ElevatedButton(
          onPressed: controller.enabled ? controller.onPressed : null,
          child: controller.child,
        ),
      ),
    );
  }
}

class EHButtonController extends EHEditableWidgetController {
  @override
  Future<bool> validateWidget() async {
    return true;
  }

  VoidCallback? onPressed;

  Widget child;

  EHButtonController({
    bool enabled = true,
    this.onPressed,
    required this.child,
  }) : super(enabled: enabled);
}
