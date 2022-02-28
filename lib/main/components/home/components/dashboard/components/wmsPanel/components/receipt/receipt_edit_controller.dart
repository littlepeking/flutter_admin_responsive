import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditPanelController.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'receipt_detail_view.dart';
import 'receipt_detail_view_controller.dart';

class ReceiptEditController extends EHEditFormController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTabsViewController receiptHeaderTabsViewController;

  late EHTabsViewController receiptDetailTabsViewController;

  late EHDataGridController asnHeaderDataGridController;

  EHDropDownController? ehDropDownMenuController;

  ReceiptDetailViewController receiptDetailInfoController =
      ReceiptDetailViewController();

  RxDouble splitterWeights = 0.5.obs;

  FocusNode fnButton = FocusNode();
  ReceiptEditController() {
    asnHeaderDataGridController = EHDataGridController(
        showCheckbox: true,
        onRowSelected: (data) =>
            EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: DataGridTest.getDataGridSource());

    receiptHeaderTabsViewController = EHTabsViewController(tabs: [
      EHTab('General Info', asnHeaderDataGridController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: Container(
              child: EHDataGrid(
                controller: c,
              ),
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    receiptDetailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Detail Info', receiptDetailInfoController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: ReceiptDetailView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);
  }

  showSelectedRows() {
    EHToastMessageHelper.showInfoMessage(asnHeaderDataGridController
        .dataGridSource
        .getSelectedRows()
        .toString());
  }
  // EHDataGridController asnDetailDataGridController = EHDataGridController(
  //     AsnHeaderDataGridSource(),
  //     fixedHeight: Responsive.isMobile(Get.context!) ? 500 : double.infinity);

}
