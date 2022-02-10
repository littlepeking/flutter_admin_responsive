import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:flutter/material.dart';

import 'receipt_detail_view.dart';
import 'receipt_edit_controller.dart';

PageStorageBucket b = PageStorageBucket();

class ReceiptEdit extends EHStatelessWidget<ReceiptEditController> {
  ReceiptEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    controller.receiptHeaderTabsViewController.showScrollArrow = false;
    controller.receiptDetailTabsViewController.showScrollArrow = false;

    controller.receiptHeaderTabsViewController.initTabs([
      EHTab('General Info', controller.asnHeaderDataGridController,
          (EHController c) {
        return PageStorage(
            bucket: b,
            child: EHDataGrid(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);
    controller.receiptDetailTabsViewController.initTabs([
      EHTab('Detail Info', controller.receiptDetailInfoController,
          (EHController c) {
        return PageStorage(
            bucket: b,
            child: ReceiptDetailView(
              controller: c,
            ));
      }),
      EHTab('Sub Grid Info', controller.asnDetailDataGridController,
          (EHController c) {
        return PageStorage(
            bucket: b,
            child: EHDataGrid(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
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
