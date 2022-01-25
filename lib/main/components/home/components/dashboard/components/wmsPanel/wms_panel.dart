import 'dart:math';

import 'package:eh_flutter_framework/main/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/TabHeader.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/controllers/wms_panel_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabbed_view/tabbed_view.dart';

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

    Map<String, Widget> OpenedTabs = {'Orders': Test(), 'Asn': Test2()};

    return Column(
      children: [
        Container(height: 50, child: TabHeader()),
        SizedBox(
            child: ElevatedButton(
                child: Text('switch page'),
                onPressed: () {
                  if (WmsPanelNavigationController.instance.pageIndex.value ==
                      0) {
                    WmsPanelNavigationController.instance.pageIndex.value = 1;
                  } else {
                    WmsPanelNavigationController.instance.pageIndex.value = 0;
                  }
                })),
        Flexible(
            child: Container(
              child: Obx(() => IndexedStack(
                    index:
                        WmsPanelNavigationController.instance.pageIndex.value,
                    children: [
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 1000,
                          width: 500,
                          child: Container(
                            color: Colors.red,
                            child: Test2(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1500,
                        child: Container(
                          height: 100,
                          width: 300,
                          alignment: Alignment.center,
                          color: Colors.blue,
                          child: Test2(),
                        ),
                      ),
                    ],
                  )),
            ),
            flex: 5)
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

  generateTabbedView() {
    ThemeController themeController = Get.find();
    var theme = Obx(() {
      var tabbedView =
          TabbedView(controller: TabbedViewController(controller.tabDataList));
      TabbedViewThemeData themeData = themeController.isDarkMode.isTrue
          ? TabbedViewThemeData.dark()
          : TabbedViewThemeData.classic();
      themeData.tabsArea
        ..initialGap = 20
        ..middleGap = 5
        ..minimalFinalGap = 5;
      return TabbedViewTheme(child: tabbedView, data: themeData);
    });
    return theme;
  }
}
