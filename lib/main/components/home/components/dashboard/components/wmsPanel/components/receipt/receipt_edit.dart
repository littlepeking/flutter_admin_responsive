import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'receipt_detail_view.dart';
import 'receipt_edit_controller.dart';

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
            expandMode: ExpandMode.Growable,
            controller: controller.receiptHeaderTabsViewController),
        EHTabsView(
            expandMode: ExpandMode.Growable,
            controller: controller.receiptDetailTabsViewController),
      ]);
    } else {
      return Column(
        children: [
          // KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
          //   return !isKeyboardVisible && !Responsive.isExtraSmall(context)
          //       ?
          Expanded(
            child: EHTabsView(
                expandMode: ExpandMode.Flexible,
                controller: controller.receiptHeaderTabsViewController),
          ),
          Expanded(
              child: EHTabsView(
                  expandMode: ExpandMode.Flexible,
                  controller: controller.receiptDetailTabsViewController)),
        ],
      );
    }
  }
}
