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
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/dashboard/dashboard.dart';
import 'components/side_menu/side_menu.dart';
import 'components/side_menu/side_menu_controller.dart';

class Home extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: SideMenuController.instance.scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // We want this side menu only for large screen
                    if (Responsive.isDesktop(context))
                      SizedBox(
                        width: 250,
                        child: SideMenu(),
                      ),
                    Expanded(
                      child: Dashboard(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: Responsive.isDesktop(context) ? 20 : 13,
                  child: EHText(
                    size: Responsive.isDesktop(context) ? 13 : 10,
                    text: " Copyright © 2022 Enhantec",
                  ))
            ]),
          ),
        ));
  }
}
