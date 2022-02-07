import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/receipt_edit/receipt_edit_controller.dart';
import 'package:flutter/material.dart';

PageStorageBucket b = PageStorageBucket();

class ReceiptEdit extends EHStatelessWidget<ReceiptEditController> {
  ReceiptEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    controller.receiptHeaderTabsViewController.showScrollArrow = false;
    controller.receiptDetailTabsViewController.showScrollArrow = false;

    controller.receiptHeaderTabsViewController.initTabs([
      EHTab('General Info', controller.asnHeaderDataGridController, f),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    // controller.receiptDetailTabsViewController.initTabs([
    //   EHTab(
    //       'General Info', controller, (controller) => JsonDataSourceDataGrid()),
    //   EHTab(
    //       'Detail Info', controller, (controller) => ColumnResizingDataGrid()),
    //   EHTab('Other', controller, (controller) => Center()),
    // ]);

    return Column(
      children: [
        Expanded(
            child: EHTabsView(
                controller: controller.receiptHeaderTabsViewController)),
        // Expanded(
        //     child: EHTabsView(
        //         controller: controller.receiptDetailTabsViewController)),
      ],
    );
  }

  Widget f(EHController c) {
    return PageStorage(
        bucket: b,
        child: EHDataGrid<EHDataGridController>(
          controller: c,
        ));
  }
}
