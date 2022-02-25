import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHDialog.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_image_button.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_multi_select.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'receipt_detail_view_controller.dart';

import 'package:intl/intl.dart';

class ReceiptDetailView extends EHStatelessWidget<ReceiptDetailViewController> {
  ReceiptDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        // padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              // SingleActivator(LogicalKeyboardKey.tab): DoNothingIntent(),
            },
            child: FocusTraversalGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(children: [
                    Obx(() => EHTextField(
                          key: controller.textKey1,
                          // autoFocus: true,
                          controller: EHTextFieldController(
                              focusNode: controller.textFn1,
                              autoFocus: true,
                              label: '测试1',
                              text: controller.receiptModel.value.receiptKey,
                              mustInput: true,
                              //  autoFocus: true,
                              onChanged: (value) =>
                                  controller.receiptModel.update((model) {
                                    model!.receiptKey = value;
                                  })),
                        )),
                    Obx(() => EHTextField(
                          key: controller.textKey2,
                          controller: EHTextFieldController(
                              focusNode: controller.textFn2,
                              label: '测试2',
                              //errorBucket: controller.errorBucket,
                              text: controller.receiptModel.value.receiptKey,
                              mustInput: true,
                              onChanged: (value) =>
                                  controller.receiptModel.update((model) {
                                    model!.receiptKey = value;
                                  })),
                        )),
                    Obx(() => EHPopup(
                          key: controller.popupKey1,
                          controller: EHPopupController(
                              popupTitle: 'Please Select Supplier',
                              focusNode: controller.popUpFn,
                              codeColumnName: 'customerId',
                              dataGridSource: DataGridTest.getDataGridSource(),
                              label: '测试1',
                              text: controller.receiptModel.value.customerId,
                              mustInput: true,
                              //  autoFocus: true,
                              onChanged: (code, row) {
                                //  controller.popUpFn!.requestFocus();
                                controller.receiptModel.update((model) {
                                  model!.customerId = code;
                                  model.customerName = row['name'] ?? '';
                                });
                              }),
                        )),
                    EHDatePicker(
                        key: controller.datePicker1,
                        controller: EHDatePickerController(
                            mustInput: true,
                            //enabled: false,
                            focusNode: controller.datePickerFn1,
                            label: '时间')),
                    Obx(() => EHDropdown(
                          key: controller.dropdownKey1,
                          controller: EHDropDownController(
                              validate: () async => true,
                              focusNode: controller.ddlFn1,
                              label: '测试4',
                              mustInput: true,
                              selectedValue:
                                  controller.receiptModel.value.dropdownValue,
                              items: {
                                '0': 'Item0',
                                '1': 'Item1',
                                '2': 'Item2',
                              },
                              onChanged: (value) =>
                                  controller.receiptModel.update((model) {
                                    model!.dropdownValue = value;
                                  })),
                        )),
                    Obx(() => EHDropdown(
                          key: controller.dropdownKey2,
                          controller: EHDropDownController(
                              focusNode: controller.ddlFn2,
                              label: '测试5',
                              enabled: false,
                              mustInput: true,
                              selectedValue:
                                  controller.receiptModel.value.dropdownValue,
                              width: 250,
                              items: {
                                '0': 'Item0',
                                '1': 'Item1',
                                '2': 'Item2',
                              },
                              onChanged: (value) =>
                                  controller.receiptModel.update((model) {
                                    model!.dropdownValue = value;
                                  })),
                        )),
                    Obx(() => EHMultiSelect(
                          key: controller.multiSelectKey1,
                          controller: EHMultiSelectController(
                              focusNode: controller.ddlFn2,
                              label: '测试5',
                              enabled: true,
                              mustInput: true,
                              selectedValues: controller
                                  .receiptModel.value.multiSelectValues,
                              width: 200,
                              items: {
                                '0': 'Item0',
                                '1': 'Item1',
                                '2': 'Item2',
                                '3': 'Item3',
                                '4': 'Item4',
                                '5': 'Item5',
                              },
                              onChanged: (value) =>
                                  controller.receiptModel.update((model) {
                                    model!.multiSelectValues = value;
                                  })),
                        )),
                  ]),
                ],
              ),
            )),
      ),
    );
  }
}
