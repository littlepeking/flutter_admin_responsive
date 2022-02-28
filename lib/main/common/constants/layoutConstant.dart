import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LayoutConstant {
  static double editWidgetSize = Responsive.isMobile(Get.context!) ? 150 : 200;
  static EdgeInsets defaultEditWidgetPadding =
      Responsive.isDesktop(Get.context!)
          ? EdgeInsets.symmetric(horizontal: 5)
          : EdgeInsets.symmetric(horizontal: 2);

  static double defaultDropDownItemWidth = 200;
}
