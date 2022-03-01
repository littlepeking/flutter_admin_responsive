import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ReceiptDetailViewController extends EHController {
  ReceiptDetailViewController() {
    widgetBuilderFormController = EHEditFormController(widgetBuilders: [
      (key, focusNode) => EHTextField(
            key: key,
            // autoFocus: true,
            controller: EHTextFieldController(
                focusNode: focusNode,
                autoFocus: true,
                label: '测试1',
                text: receiptModel.value.receiptKey,
                mustInput: true,
                onChanged: (value) => receiptModel.update((model) {
                      model!.receiptKey = value;
                    })),
          ),
      (key, focusNode) => EHPopup(
            key: key,
            controller: EHPopupController(
                popupTitle: 'Please Select Supplier',
                focusNode: focusNode,
                codeColumnName: 'customerId',
                dataGridSource: DataGridTest.getDataGridSource(),
                label: 'popUp',
                text: receiptModel.value.customerId,
                mustInput: true,
                //  autoFocus: true,
                onChanged: (code, row) {
                  //  controller.popUpFn!.requestFocus();
                  receiptModel.update((model) {
                    model!.customerId = code;
                    model.customerName = row?['name'] ?? '';
                  });
                }),
          ),
      (key, focusNode) => EHDatePicker(
          key: key,
          controller: EHDatePickerController(
              mustInput: true,
              //enabled: false,
              focusNode: focusNode,
              dateTime: receiptModel.value.dateTime,
              onChanged: (value) => receiptModel.update((model) {
                    model!.dateTime = value;
                  }),
              label: 'date')),
    ]);

    widgetControllerFormController = EHEditFormController(widgetControllers: [
      EHTextFieldController(
          autoFocus: true,
          label: '测试1',
          text: receiptModel.value.receiptKey,
          mustInput: true,
          onChanged: (value) => receiptModel.update((model) {
                model!.receiptKey = value;
              })),
      EHPopupController(
          popupTitle: 'Please Select Supplier',
          codeColumnName: 'customerId',
          dataGridSource: DataGridTest.getDataGridSource(),
          label: 'popUp',
          text: receiptModel.value.customerId,
          mustInput: true,
          //  autoFocus: true,
          onChanged: (code, row) {
            //  controller.popUpFn!.requestFocus();
            receiptModel.update((model) {
              model!.customerId = code;
              model.customerName = row?['name'] ?? '';
            });
          }),
      EHDatePickerController(
          mustInput: true,
          //enabled: false,
          dateTime: receiptModel.value.dateTime,
          onChanged: (value) => receiptModel.update((model) {
                model!.dateTime = value;
              }),
          label: 'date'),
    ]);
  }

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

  late EHEditFormController widgetBuilderFormController;

  late EHEditFormController widgetControllerFormController;
}
