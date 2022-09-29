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

import 'package:enhantec_frontend_project/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_frontend_project/main/common/constants/constants.dart';
import 'package:enhantec_frontend_project/main/common/utils/context_helper.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/dashboard_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'components/header.dart';
import 'package:get/get.dart';

class Dashboard extends GetView<DashBoardNavigationController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashBoardNavigationController());
    return SafeArea(
      child: Container(
        padding: !Responsive.isMobile(context)
            ? EdgeInsets.only(
                left: LayoutConstant.defaultPadding,
                right: LayoutConstant.defaultPadding,
                top: LayoutConstant.defaultPadding)
            : EdgeInsets.only(left: 0, right: 0, top: 0),
        child: Column(
          children: [
            if (!Responsive.isMobile(context)) Header(),
            //SizedBox(height: defaultPadding),
            Expanded(
              child: Navigator(
                key: controller.navigatorKey,
                onGenerateRoute: controller.generateRoute,
                initialRoute: MapConstant
                    .systemModuleRoute[ContextHelper.currentModule.value],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
