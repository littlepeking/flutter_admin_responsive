import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
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
          (controller) => Center(
                child: Container(
                  width: !Responsive.isMobile(Get.context!) ? 500 : null,
                  height: !Responsive.isMobile(Get.context!) ? 500 : null,
                  padding: EdgeInsets.all(10),
                  //   padding: EdgeInsets.all(50),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Obx(() => Image.asset(
                          !ThemeController.instance.isDarkMode.value
                              ? 'assets/images/background_image5.png'
                              : 'assets/images/background_image5_dark.jpg',
                          //#Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
          showInBottomList: false,
          tabTranslateParams: {'System': 'WMS'}));

    return PageStorage(
        bucket: globalPageStorageBucket,
        child: Column(children: [
          Expanded(
              child: EHTabsView(
                  showSideBorder: false,
                  useBottomList: Responsive.isMobile(context),
                  expandMode: Responsive.isMobile(context)
                      ? EHTabsViewExpandMode.Scrollable
                      : EHTabsViewExpandMode.Flexible,
                  key: PageStorageKey('wmsPanelTabView'),
                  preTabHeaderWidget: Responsive.isMobile(context)
                      ? IconButton(
                          padding: EdgeInsets.zero,
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
