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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_module_widget.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/constants/constants.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_platform_ui/main/components/home/components/dashboard/components/workbench_module/workbench_module_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkbenchModuleWidget extends EHModuleWidget<WorkbenchModuleController> {
  WorkbenchModuleWidget({super.key, required super.controller});

  @override
  Widget build(BuildContext context) {
    // wmsModuleController.reset();

    if (controller.moduleTabViewController.tabsConfig.length == 0)
      controller.moduleTabViewController.tabsConfig.add(EHTab(
          'welcome',
          'common.general.welcome',
          EHController(),
          (controller) => Center(
                child: Container(
                  width: !Responsive.isMobile(Get.context!) ? 500 : null,
                  height: !Responsive.isMobile(Get.context!) ? 500 : null,
                  padding: EdgeInsets.all(10),
                  //   padding: EdgeInsets.all(50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Obx(() => Image.asset(
                          !EHThemeHelper.isDarkMode.value
                              ? 'assets/images/background_image5.png'
                              : 'assets/images/background_image5_dark.jpg',
                          //#Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
          showInBottomList: false,
          tabTranslateParams: {'System': 'common.module.workbench'}));

    return PageStorage(
        bucket: globalPageStorageBucket,
        child: Column(children: [
          Expanded(
              child: EHTabsView(
                  showSideBorder: false,
                  useBottomList: Responsive.isMobile(context),
                  expandMode: Responsive.isMobile(context)
                      ? EHTabsViewExpandMode.Scroll
                      : EHTabsViewExpandMode.Expand,
                  key: PageStorageKey('WorkbenchModuleTabView'),
                  preTabHeaderWidget: Responsive.isMobile(context)
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.menu),
                          onPressed: SideMenuController.instance.toggleDrawer,
                        )
                      : null,
                  controller: controller.moduleTabViewController))
        ]));

    //     if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
    //     // On Mobile means if the screen is less than 850 we dont want to show it
    //     // if (!Responsive.isMobile(context))
    //     //   Expanded(
    //     //     flex: 2,
    //     //     child: Notifications(),
    //     //   ),
    //   ],
    // ));
  }
}
