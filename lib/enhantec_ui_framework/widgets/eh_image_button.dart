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

import 'package:enhantec_platform_ui/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHImageButton<T> extends StatelessWidget {
  final Icon icon;
  final double? iconSize;
  final String textMsgKey;
  final ValueChanged<T?> onPressed;
  final T? data;
  final double? padding;
  final BoxDecoration? decoration;
  final bool? showButtonText;
  const EHImageButton(
      {Key? key,
      this.padding = 2,
      this.showButtonText,
      required this.icon,
      this.decoration,
      this.iconSize,
      required this.textMsgKey,
      this.data,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showText = showButtonText ?? Responsive.isDesktop(context);

    return (!showText)
        ? Container(
            child: IconButton(
              iconSize: iconSize ?? 24,
              padding: EdgeInsets.all(
                  padding ?? (!Responsive.isDesktop(Get.context!) ? 2 : 8)),
              onPressed: () => onPressed(data),
              icon: icon,
              tooltip: this.textMsgKey.tr,
            ),
            decoration: decoration)
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => onPressed(data),
                child: Container(
                  margin: EdgeInsets.only(left: LayoutConstant.defaultPadding),
                  padding: EdgeInsets.symmetric(
                    horizontal: LayoutConstant.defaultPadding,
                    vertical: LayoutConstant.defaultPadding / 2,
                  ),
                  decoration: decoration,
                  child: Row(
                    children: [
                      icon,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: LayoutConstant.defaultPadding / 2),
                        child: Text(textMsgKey.tr),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                )));
  }
}
