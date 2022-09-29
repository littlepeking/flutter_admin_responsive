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
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_theme_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_frontend_project/main/components/home/components/dashboard/components/system_module/system_module_controller.dart';
import 'package:enhantec_frontend_project/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemModuleWidget extends StatelessWidget {
  SystemModuleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemModuleController systemModuleController = Get.put(
      SystemModuleController(),
      permanent: true,
    );

    // wmsModuleController.reset();

    if (systemModuleController.tabViewController.tabsConfig.length == 0)
      systemModuleController.tabViewController.tabsConfig.add(EHTab(
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
          tabTranslateParams: {'System': 'common.module.system'}));

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
                  key: PageStorageKey('SystemModuleTabView'),
                  preTabHeaderWidget: Responsive.isMobile(context)
                      ? IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.menu),
                          onPressed: SideMenuController.instance.toggleDrawer,
                        )
                      : null,
                  controller: systemModuleController.tabViewController))
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
