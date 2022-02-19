import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'receipt_detail_view.dart';
import 'receipt_edit_controller.dart';

import 'package:split_view/split_view.dart';

class ReceiptEdit extends EHStatelessWidget<ReceiptEditController> {
  ReceiptEdit({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return Column(children: [
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 35,
            child: Row(
              children: [
                ElevatedButton(
                  focusNode: controller.fnButton,
                  onPressed: () {
                    controller.validateForm();
                    EHToastMessageHelper.showInfoMessage(
                        MediaQuery.of(context).viewInsets.bottom.toString());
                  },
                  child: Text('Validate Form'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SplitView(
              children: [
                EHTabsView(
                    controller: controller.receiptDetailTabsViewController),
                EHTabsView(
                    expandMode: EHTabsViewExpandMode.Flexible,
                    controller: controller.receiptHeaderTabsViewController),
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
}
