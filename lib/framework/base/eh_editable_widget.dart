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
import 'package:flutter/material.dart';

abstract class EHEditableWidget<T extends EHEditableWidgetController>
    extends StatelessWidget {
  final T controller;

  EHEditableWidget({Key? key, required this.controller}) : super(key: key) {
    // if (this.controller.key == null) {
    //   this.controller.key = key ?? GlobalKey();
    // }
  }

  Future<bool> validate() async {
    return await controller.validateWidget();
  }
}
