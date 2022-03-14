import 'dart:convert';

import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/services/wms/outbound/receipt_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../../../../common/widgets/eh_button.dart';
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
            expandMode: EHTabsViewExpandMode.Growable,
            controller: controller.receiptHeaderTabsViewController),
        EHTabsView(
            useBottomList: false,
            expandMode: EHTabsViewExpandMode.Growable,
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
                    expandMode: EHTabsViewExpandMode.Flexible,
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
            List<ReceiptModel> list = await ReceiptService().query(
                conditions: controller
                    .asnHeaderDataGridController.dataGridSource.filters);

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
          width: 75,
          child: EHDropdown(
              controller: EHDropDownController(
            key: GlobalKey(),
            focusNode: FocusNode(),
            isMenu: true,
            dropDownWidth: 150,
            label: 'Actions',
            items: {
              'receivingASN': 'Receiving ASN',
              'closeASN': 'Close ASN',
              'printItemLabel': 'Print SKU Label'
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
