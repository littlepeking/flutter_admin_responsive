import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'receipt_edit_controller.dart';
import 'package:split_view/split_view.dart';

class ReceiptEdit extends EHStatelessWidget<ReceiptEditController> {
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

  Container buildToolbar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 36,
      child: Row(
        children: [
          ElevatedButton(
            focusNode: controller.fnButton,
            onPressed: () {
              controller
                  .receiptDetailInfoController.widgetControllerFormController
                  .validate();
              controller.receiptDetailInfoController.widgetBuilderFormController
                  .validate();
              String modelStr = controller
                  .receiptDetailInfoController.receiptModel.value
                  .toJsonStr();
              print(modelStr);
              EHToastMessageHelper.showInfoMessage(modelStr);
            },
            child: Text('Validate Form'.tr),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              EHToastMessageHelper.showInfoMessage(controller
                  .asnHeaderDataGridController.dataGridSource
                  .getSelectedRows()
                  .toString());
            },
            child: Text('Show Selected Rows'.tr),
          ),
          EHDropdown(
              key: GlobalKey(),
              controller: EHDropDownController(
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
                    controller.receiptDetailInfoController.receiptModel
                        .refresh();
                  }
                },
              ))
        ],
      ),
    );
  }
}
