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

import 'dart:convert';

import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/services/wms/outbound/receipt_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../../../../common/widgets/eh_button.dart';
import '../../../../../../../../common/widgets/eh_datagrid/eh_datagrid_filter_data.dart';
import '../../../../../../../../common/widgets/eh_toolbar.dart';
import 'receipt_edit_controller.dart';
import 'package:split_view/split_view.dart';

class ReceiptEdit extends EHPanel<ReceiptEditController> {
  ReceiptEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(children: [
        buildToolbar(context),
        // KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        //   return !isKeyboardVisible && !Responsive.isExtraSmall(context)
        //       ?
        EHTabsView(
            useBottomList: false,
            expandMode: EHTabsViewExpandMode.None,
            controller: controller.receiptHeaderTabsViewController),
        EHTabsView(
            useBottomList: false,
            expandMode: EHTabsViewExpandMode.None,
            controller: controller.receiptDetailTabsViewController),
      ]);
    } else {
      return Column(
        children: [
          buildToolbar(context),
          Expanded(
            child: SplitView(
              children: [
                EHTabsView(
                    expandMode: EHTabsViewExpandMode.Expand,
                    controller: controller.receiptHeaderTabsViewController),
                EHTabsView(
                    controller: controller.receiptDetailTabsViewController),
              ],
              gripSize: 2,
              viewMode: SplitViewMode.Vertical,
              indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
              activeIndicator: SplitIndicator(
                viewMode: SplitViewMode.Vertical,
                isActive: true,
              ),
              controller: SplitViewController(
                  limits: [WeightLimit(max: 0.8), WeightLimit(max: 0.8)],
                  weights: [controller.splitterWeights.value]),
              onWeightChanged: (w) =>
                  controller.splitterWeights.value = w.first ?? 0.5,
            ),
          ),
        ],
      );
    }
  }

  buildToolbar(BuildContext context) {
    return EHToolBar(
      children: [
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            await controller
                .receiptDetailInfoController.widgetControllerFormController!
                .validate();
            await controller
                .receiptDetailInfoController.widgetBuilderFormController
                .validate();
            String modelStr = controller
                .receiptDetailInfoController.receiptModel.value
                .toJsonStr();
            print(modelStr);

            await ReceiptService().createOrUpdateModel(
                model:
                    controller.receiptDetailInfoController.receiptModel.value);

            //controller.receiptDetailInfoController.receiptModel.value = model;

            controller.receiptDetailInfoController.receiptModel.refresh();

            EHToastMessageHelper.showInfoMessage(modelStr);
          },
          child: Text('Validate Form'.tr),
        )),
        EHButton(
            controller: EHButtonController(
          onPressed: () async {
            print(jsonEncode(
                controller.asnHeaderDataGridController.dataGridSource.filters));
            EHToastMessageHelper.showInfoMessage(jsonEncode(
                controller.asnHeaderDataGridController.dataGridSource.filters));
            List list = await ReceiptService().queryByConditions(
                conditions: Map.fromIterable(
                    controller
                        .asnHeaderDataGridController.dataGridSource.filters,
                    key: (e) => (e as EHDataGridFilterData).columnName,
                    value: (e) => (e as EHDataGridFilterData).value));

            EHToastMessageHelper.showInfoMessage(list.toString());
          },
          child: Text('Show Grid Filters'.tr),
        )),
        EHButton(
          controller: EHButtonController(
              child: Text('Show Selected Rows'.tr),
              onPressed: () => EHToastMessageHelper.showInfoMessage(controller
                  .asnHeaderDataGridController.dataGridSource
                  .getSelectedRows()
                  .toString())),
        ),
        Container(
          // width: 90,
          child: EHDropdown(
              controller: EHDropDownController(
            key: GlobalKey(),
            focusNode: FocusNode(),
            isMenu: true,
            dropDownWidth: 150,
            labelMsgKey: 'common.general.actions',
            items: {
              'receivingASN': 'wms.receivingASN',
              'closeASN': 'wms.closeASN',
              'printItemLabel': 'wms.printSKULabel'
            },
            onChanged: (value) {
              if (value == 'receivingASN') {
                controller.receiptDetailInfoController.receiptModel.value
                    .multiSelectValues = ['2'];
                controller.receiptDetailInfoController.receiptModel.value
                    .receiptKey = 'changed';
                controller.receiptDetailInfoController.receiptModel.refresh();
              }
            },
          )),
        )
      ],
    );
  }
}
