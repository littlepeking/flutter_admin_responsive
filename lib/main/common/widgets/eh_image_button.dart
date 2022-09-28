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

import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class EHImageButton<T> extends StatelessWidget {
  final Icon icon;
  final double? iconSize;
  final String textMsgKey;
  final ValueChanged<T?> onPressed;
  final T? data;
  final double? padding;
  final bool? isSelected;

  const EHImageButton(
      {Key? key,
      this.padding = 2,
      required this.icon,
      this.isSelected,
      this.iconSize,
      required this.textMsgKey,
      this.data,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobile(context))
        ? Obx(() => Container(
              child: IconButton(
                iconSize: iconSize ?? 24,
                padding: EdgeInsets.all(
                    padding ?? (Responsive.isMobile(Get.context!) ? 2 : 8)),
                onPressed: () => onPressed(data),
                icon: icon,
                tooltip: this.textMsgKey.tr,
              ),
              decoration: BoxDecoration(
                border: isSelected == true
                    ? Border(
                        bottom: BorderSide(
                            width: 3.0, color: EHThemeHelper.getTextColor()))
                    : Border(
                        bottom: BorderSide(
                            width: 3.0,
                            color: EHThemeHelper.getBackgroundColor())),
              ),
            ))
        : MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
                onTap: () => onPressed(data),
                child: Obx(() => Container(
                      margin: EdgeInsets.only(left: defaultPadding),
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: isSelected == true
                                  ? BorderSide(
                                      width: 3.0,
                                      color: EHThemeHelper.getTextColor())
                                  : BorderSide(
                                      width: 3.0,
                                      color:
                                          EHThemeHelper.getBackgroundColor()))),
                      child: Row(
                        children: [
                          icon,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: Text(textMsgKey.tr),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                    ))));
  }
}
