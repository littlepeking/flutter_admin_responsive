/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_platform_ui/framework/base/eh_controller.dart';
import 'package:enhantec_platform_ui/framework/base/eh_panel_controller.dart';
import 'package:enhantec_platform_ui/framework/utils/eh_toast_helper.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_dropdown.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_tabs_view/eh_tab.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:enhantec_platform_ui/example/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'receipt_detail_view.dart';
import 'receipt_detail_view_controller.dart';

class ReceiptEditController extends EHPanelController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTabsViewController receiptHeaderTabsViewController;

  late EHTabsViewController receiptDetailTabsViewController;

  late EHDataGridController asnHeaderDataGridController;

  EHDropDownController? ehDropDownMenuController;

  late ReceiptDetailViewController receiptDetailInfoController;

  RxDouble splitterWeights = 0.5.obs;

  FocusNode fnButton = FocusNode();
  ReceiptEditController() : super(null) {
    receiptDetailInfoController = ReceiptDetailViewController(this);
    // initChildPanel(receiptDetailInfoController);

    asnHeaderDataGridController = EHDataGridController(
        showCheckbox: true,
        onRowSelected: (data) =>
            EHToastMessageHelper.showInfoMessage(data.toString()),
        dataGridSource: DataGridTest.getDataGridSource());

    receiptHeaderTabsViewController = EHTabsViewController(tabs: [
      EHTab('generalInfo', 'common.general.generalInfo',
          asnHeaderDataGridController, (EHController c) {
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
      EHTab('generalInfo', 'common.general.detailInfo',
          receiptDetailInfoController, (EHController c) {
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
