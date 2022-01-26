import 'dart:math';

import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/tab_data.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/controllers/wms_panel_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/TestComponent/TestController.dart';
import 'components/TestComponent/test.dart';
import 'components/TestComponent/test2.dart';

class WmsPanelWidget extends GetView<WmsPanelNavigationController> {
  const WmsPanelWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(WmsPanelNavigationController(), permanent: true);

    Get.create(() => TestController());

    const double tabWidth = 100;

    EHTabsViewController wmsPanelTabsController =
        Get.put(EHTabsViewController(), tag: wmsMainPanelTabsViewTag);
    wmsPanelTabsController.tabsData = [
      TabData('Welcome1', Text('Welcome')),
      TabData('Orders2', Test()),
      TabData('Welcome3', Text('Welcome')),
      TabData('Orders4', Test()),
      TabData('Welcome5', Text('Welcome')),
      TabData('Orders6', Test()),
      TabData('Welcome7', Text('Welcome')),
      TabData('Orders8', Test()),
      TabData('Welcome9', Text('Welcome')),
      TabData('Orders10', Test()),
      TabData('Welcome1', Text('Welcome')),
      TabData('Orders12', Test()),
      TabData('Asn', Test2(tabName: 'Asn'))
    ].obs;

    return Column(
      children: [
        Container(
            height: 500, child: EHTabsView(controller: wmsPanelTabsController)),
        // SizedBox(
        //     child: ElevatedButton(
        //         child: Text('switch page'),
        //         onPressed: () {
        //           if (WmsPanelNavigationController.instance.pageIndex.value ==
        //               0) {
        //             WmsPanelNavigationController.instance.pageIndex.value = 1;
        //           } else {
        //             WmsPanelNavigationController.instance.pageIndex.value = 0;
        //           }
        //         })),
      ],
    );

    // return Container(
    //     child: Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Expanded(
    //       flex: 5,
    //       child: Column(
    //         children: [
    //           if (Responsive.isMobile(context))
    //             SizedBox(height: defaultPadding),
    //           //if (Responsive.isMobile(context)) Notifications(),
    //           //Biz widget goes here
    //           Expanded(
    //             child: generateTabbedView(),
    //           ),
    //         ],
    //       ),
    //     ),
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
