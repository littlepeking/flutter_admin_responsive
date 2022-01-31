import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/tmsPanel/tms_panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TmsPanelWidget extends StatefulWidget {
  TmsPanelWidget({Key? key}) : super(key: key);

  @override
  _TmsPanelWidgetState createState() => _TmsPanelWidgetState();
}

class _TmsPanelWidgetState extends State<TmsPanelWidget> {
  @override
  Widget build(BuildContext context) {
    TmsPanelController tmsPanelController =
        Get.put(TmsPanelController(), permanent: true);

    //tmsPanelController.reset();

    if (tmsPanelController.tabViewController.tabsConfig.length == 0)
      tmsPanelController.tabViewController.tabsConfig.add(EHTab(
          'Welcome Page'.trParams({'system': 'TMS'}),
          EHController(),
          (controller) => Container(
                padding: EdgeInsets.all(50),
                child: EHText(
                    weight: FontWeight.bold,
                    text: 'Welcome use Enhantec TMS System!'.tr),
              )));

    return EHTabsView(controller: tmsPanelController.tabViewController);
  }
}
