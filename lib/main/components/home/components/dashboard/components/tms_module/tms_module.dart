import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tms_module/tms_module_controller.dart';
import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
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
