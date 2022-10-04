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

import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHEditErrorInfo extends StatelessWidget {
  EHEditErrorInfo({
    Key? key,
    required this.error,
  });
  final String error;
  @override
  Widget build(BuildContext context) {
    return EHUtilHelper.isEmpty(error)
        ? SizedBox(height: Responsive.isMobile(context) ? 0 : 5)
        : Center(
            child: Row(
              children: [
                Icon(Icons.error_outline,
                    size: 18,
                    color: EHThemeHelper.getThemeColor(
                        Colors.yellow.shade200, Colors.red)),
                Flexible(
                  child: Obx(() {
                    return Text(
                      error,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: TextStyle(
                          color: EHThemeHelper.getThemeColor(
                              Colors.yellow.shade200, Colors.red)),
                    );
                  }),
                )
              ],
            ),
          );
  }
}
