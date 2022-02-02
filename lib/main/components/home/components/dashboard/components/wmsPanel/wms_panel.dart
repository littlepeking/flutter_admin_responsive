import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/wms_panel_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WmsPanelWidget extends StatelessWidget {
  WmsPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WmsPanelController wmsPanelController =
        Get.put(WmsPanelController(), permanent: true);

    // wmsPanelController.reset();

    if (wmsPanelController.tabViewController.tabsConfig.length == 0)
      wmsPanelController.tabViewController.tabsConfig.add(EHTab(
          '%System Welcome Page',
          EHController(),
          (controller) => Container(
                padding: EdgeInsets.all(50),
                child: EHText(
                    weight: FontWeight.bold,
                    text: 'Welcome use Enhantec WMS System!'.tr),
              ),
          showInBottomList: false,
          tabTranslateParams: {'System': 'WMS'}));

    return PageStorage(
        bucket: globalPageStorageBucket,
        child: Column(children: [
          Expanded(
              child: EHTabsView(
                  key: PageStorageKey('wmsPanelTabView'),
                  preTabHeaderWidget: Responsive.isMobile(context)
                      ? IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: SideMenuController.instance.toggleDrawer,
                        )
                      : null,
                  controller: wmsPanelController.tabViewController))
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
