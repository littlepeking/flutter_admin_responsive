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

import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutConstant {
  static double editWidgetSize = Responsive.isMobile(Get.context!) ? 150 : 200;
  static EdgeInsets defaultEditWidgetPadding =
      Responsive.isDesktop(Get.context!)
          ? EdgeInsets.symmetric(horizontal: 5)
          : EdgeInsets.symmetric(horizontal: 2);

  static double defaultDropDownItemWidth = 200;

  static const primaryColor = Color(0xFF2697FF);
  static const secondaryColor = Color(0xFF2A2D3E);
  static const bgColor = Color(0xFF212332);

  static const creamColor = Color(0xFFFFFFFF);
  static const snowColor = Color(0xFFFFFAFA);

  static const double defaultPadding = 4.0;
}
