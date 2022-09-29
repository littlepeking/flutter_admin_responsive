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

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/constants/constants.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_text.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:enhantec_frontend_project/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmsModuleWidget extends StatefulWidget {
  TmsModuleWidget({Key? key}) : super(key: key);

  @override
  _TmsModuleWidgetState createState() => _TmsModuleWidgetState();
}

class _TmsModuleWidgetState extends State<TmsModuleWidget> {
  @override
  Widget build(BuildContext context) {
    TmsModuleController tmsModuleController =
        Get.put(TmsModuleController(), permanent: true);

    if (tmsModuleController.tabViewController.tabsConfig.length == 0)
      tmsModuleController.tabViewController.tabsConfig.add(EHTab(
          'welcome',
          'common.general.welcome',
          EHController(),
          (controller) => Container(
                padding: EdgeInsets.all(50),
                child: EHText(
                    weight: FontWeight.bold,
                    text: 'Welcome use Enhantec TMS System!'.tr),
              ),
          showInBottomList: false,
          tabTranslateParams: {'System': 'TMS'}));

    return PageStorage(
        bucket: globalPageStorageBucket,
        child: Column(children: [
          Expanded(
              child: EHTabsView(
                  expandMode: Responsive.isMobile(context)
                      ? EHTabsViewExpandMode.Scroll
                      : EHTabsViewExpandMode.Expand,
                  key: PageStorageKey('tmsModuleTabView'),
                  preTabHeaderWidget: Responsive.isMobile(context)
                      ? IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: SideMenuController.instance.toggleDrawer,
                        )
                      : null,
                  controller: tmsModuleController.tabViewController))
        ]));
  }
}
