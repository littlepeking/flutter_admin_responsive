import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/tab_data.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/controllers/wms_panel_navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WmsPanelWidget extends GetView<WmsPanelNavigationController> {
  const WmsPanelWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(WmsPanelNavigationController(), permanent: true);

    EHTabsViewController wmsPanelTabsController =
        Get.put(EHTabsViewController(), tag: wmsMainPanelTabsViewTag);

    wmsPanelTabsController.tabsData = [
      TabData(
          'Welcome',
          Container(
            padding: EdgeInsets.all(50),
            child: EHText(
                weight: FontWeight.bold,
                text: 'Welcome use Enhantec Logistics System Suite!'.tr),
          )),
    ].obs;

    return EHTabsView(controller: wmsPanelTabsController);
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
