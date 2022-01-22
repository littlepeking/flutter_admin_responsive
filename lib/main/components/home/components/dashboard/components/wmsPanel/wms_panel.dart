import 'package:eh_flutter_framework/common/Utils/responsive.dart';
import 'package:eh_flutter_framework/common/constants.dart';
import 'package:eh_flutter_framework/common/utils/ThemeController.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/controllers/wms_panel_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabbed_view/tabbed_view.dart';

class WmsPanelWidget extends GetView<WmsPanelNavigationController> {
  const WmsPanelWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController(), permanent: true);
    Get.put(WmsPanelNavigationController(), permanent: true); //状态持久保留

    ThemeController themeController = Get.find();
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(controller.isDarkMode.isTrue.toString())),

        Expanded(
          flex: 5,
          child: Column(
            children: [
              if (Responsive.isMobile(context))
                SizedBox(height: defaultPadding),
              //if (Responsive.isMobile(context)) Notifications(),
              //Biz widget goes here
              Expanded(
                child: generateTabbedView(),
              ),
            ],
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we dont want to show it
        // if (!Responsive.isMobile(context))
        //   Expanded(
        //     flex: 2,
        //     child: Notifications(),
        //   ),
      ],
    ));
  }

  generateTabbedView() {
    var theme = Obx(() {
      var tabbedView =
          TabbedView(controller: TabbedViewController(controller.tabDataList));
      TabbedViewThemeData themeData = controller.isDarkMode.isTrue
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
