import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_panel.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_check_box.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wms_module/components/receipt/models/receipt_model.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../common/widgets/eh_multi_select.dart';
import 'receipt_detail_view_controller.dart';

class ReceiptDetailView extends EHPanel<ReceiptDetailViewController> {
  ReceiptDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    if (EHController.globalErrorBucket[controller.testKey] == null) {
      EHController.setWidgetError(
          EHController.globalErrorBucket, controller.testKey, '');
    }
    return Column(
      children: [
        // Obx(() => Column(
        //       children: [
        //         Text(controller.ddlType.value),
        //         EHEditForm(
        //             controller:
        //                 controller.getWidgetControllerFormController!()),
        //       ],
        //     )),
        Obx(() => EHEditForm<ReceiptModel>(
            controller: controller.getWidgetControllerFormController!())),
        EHEditForm(controller: controller.widgetBuilderFormController),
        Container(
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
                              // autoFocus: true,
                              controller: EHTextFieldController(
                                  key: controller.textKey1,
                                  focusNode: controller.textFn1,
                                  //autoFocus: true,
                                  label: '测试1',
                                  bindingValue: controller
                                          .receiptModel.value.receiptKey ??
                                      '',
                                  mustInput: true,
                                  //  autoFocus: true,
                                  onEditingComplete: (value) {
                                    if (controller
                                            .receiptModel.value.receiptKey !=
                                        value)
                                      controller.receiptModel.update((model) {
                                        model!.receiptKey = value;
                                      });
                                  }),
                            )),
                        Obx(() => EHPopup(
                              controller: EHPopupController(
                                  key: controller.popupKey1,
                                  popupTitle: 'Please Select Supplier',
                                  focusNode: controller.popUpFn,
                                  codeColumnName: 'receiptKey',
                                  dataSource: DataGridTest.getDataGridSource(),
                                  label: 'popUp',
                                  bindingValue:
                                      controller.receiptModel.value.receiptKey,
                                  mustInput: true,
                                  //  autoFocus: true,
                                  onEditingComplete: (code, row) {
                                    //  controller.popUpFn!.requestFocus();
                                    controller.receiptModel.update((model) {
                                      model!.receiptKey = code;
                                      model.customerName = row?['name'] ?? '';
                                    });
                                  }),
                            )),
                        //if we need create widget controller in parent container Controller, then we have to pass function instead of passing controller directly
                        //otherwise it will cause obx exception,because obx cannot aware the observable object in the controller.
                        Obx(() => EHDatePicker(
                            controller:
                                controller.datePicker1ControllerFunc())),
                        Obx(() => EHDropdown(
                              controller: EHDropDownController(
                                  key: controller.dropdownKey1,
                                  focusNode: controller.ddlFn1,
                                  label: 'popUp',
                                  mustInput: true,
                                  bindingValue: controller
                                      .receiptModel.value.dropdownValue,
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
                        Obx(() => EHDatePicker(
                            controller: EHDatePickerController(
                                key: controller.datePicker2,
                                mustInput: true,
                                showTimePicker: true,
                                focusNode: controller.datePickerFn2,
                                bindingValue:
                                    controller.receiptModel.value.dateTime2,
                                onEditingComplete: (value) =>
                                    controller.receiptModel.update((model) {
                                      model!.dateTime2 = value;
                                    }),
                                label: 'date'))),
                        Obx(() => EHDropdown(
                              controller: EHDropDownController(
                                  key: controller.dropdownKey2,
                                  focusNode: controller.ddlFn2,
                                  label: '测试5',
                                  enabled: false,
                                  mustInput: true,
                                  bindingValue: controller
                                      .receiptModel.value.dropdownValue,
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
                              controller: EHMultiSelectController(
                                  key: controller.multiSelectKey1,
                                  focusNode: controller.multiSelectFn1,
                                  label: '测试5',
                                  enabled: true,
                                  mustInput: true,
                                  bindingValue: controller
                                      .receiptModel.value.multiSelectValues,
                                  width: 200,
                                  items: {
                                    '0': 'Item0',
                                    '1': 'Item1',
                                    '2': 'Item2',
                                  },
                                  onChanged: (value) =>
                                      controller.receiptModel.update((model) {
                                        model!.multiSelectValues = value;
                                      })),
                            )),
                        Obx(() => EHCheckBox(
                              controller: EHCheckBoxController(
                                  key: controller.checkBoxKey1,
                                  focusNode: controller.checkBoxFn1,
                                  label: '选择框',
                                  enabled: true,
                                  mustInput: true,
                                  bindingValue:
                                      controller.receiptModel.value.isChecked,
                                  width: 200,
                                  onChanged: (value) =>
                                      controller.receiptModel.update((model) {
                                        model!.isChecked = value;
                                      })),
                            )),
                        Obx(() => EHTextField(
                              controller: EHTextFieldController(
                                  key: controller.textKey2,
                                  focusNode: controller.textFn2,
                                  label: '测试2',
                                  //errorBucket: controller.errorBucket,
                                  bindingValue: controller
                                          .receiptModel.value.receiptKey ??
                                      '',
                                  mustInput: true,
                                  onEditingComplete: (value) =>
                                      controller.receiptModel.update((model) {
                                        model!.receiptKey = value;
                                      })),
                            )),
                      ]),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
