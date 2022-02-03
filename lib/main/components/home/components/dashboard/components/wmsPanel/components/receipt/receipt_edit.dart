import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/receipt_edit_controller.dart';
import 'package:flutter/material.dart';

class ReceiptEdit extends EHStatelessWidget<ReceiptEditController> {
  ReceiptEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    controller.receiptHeaderTabsViewController.showScrollArrow = false;
    controller.receiptDetailTabsViewController.showScrollArrow = false;

    controller.receiptHeaderTabsViewController.initTabs([
      EHTab('General Info', controller, (controller) => Container()),
      EHTab('Summary Info', controller, (controller) => Container()),
      EHTab('Other', controller, (controller) => Container()),
    ]);

    controller.receiptDetailTabsViewController.initTabs([
      EHTab('General Info', controller, (controller) => Container()),
      EHTab('Detail Info', controller, (controller) => Container()),
      EHTab('Other', controller, (controller) => Container()),
    ]);

    return Column(
      children: [
        Expanded(
            child: EHTabsView(
                controller: controller.receiptHeaderTabsViewController)),
        Expanded(
            child: EHTabsView(
                controller: controller.receiptDetailTabsViewController)),
      ],
    );
  }
}
