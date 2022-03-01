import 'package:eh_flutter_framework/main/common/base/EHEditPanelController.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ReceiptDetailViewController extends EHEditFormController {
  FocusNode popUpFn = FocusNode();
  FocusNode textFn1 = FocusNode(
      //   onKeyEvent: (n, event) {
      //   if (event.logicalKey == LogicalKeyboardKey.tab) {
      //     // Do something
      //     if (n.context!.widget is EditableText) {
      //       (n.context!.widget as EditableText).onEditingComplete!();
      //     }
      //     return KeyEventResult.handled;
      //   } else {
      //     return KeyEventResult.ignored;
      //   }
      // }
      );
  FocusNode textFn2 = FocusNode();
  FocusNode ddlFn1 = FocusNode();
  FocusNode ddlFn2 = FocusNode();

  FocusNode datePickerFn1 = FocusNode();

  FocusNode datePickerFn2 = FocusNode();

  GlobalKey popupKey1 = GlobalKey();
  GlobalKey textKey1 = GlobalKey();
  GlobalKey textKey2 = GlobalKey();
  GlobalKey dropdownKey1 = GlobalKey();
  GlobalKey dropdownKey2 = GlobalKey();

  GlobalKey multiSelectKey1 = GlobalKey();

  GlobalKey datePicker1 = GlobalKey();

  GlobalKey datePicker2 = GlobalKey();

  Rx<ReceiptModel> receiptModel = ReceiptModel(
          receiptKey: 'key001',
          customerId: 'cus001',
          customerName: 'cus001Name',
          dropdownValue: '1',
          multiSelectValues: [],
          dateTime: DateTime.now(),
          dateTime2: null)
      .obs;
}
