import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'receipt_detail_view_controller.dart';

class ReceiptDetailView extends EHStatelessWidget<ReceiptDetailViewController> {
  ReceiptDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    GlobalKey textKey1 = GlobalKey();
    GlobalKey textKey2 = GlobalKey();
    GlobalKey popupKey1 = GlobalKey();
    GlobalKey dropdownKey1 = GlobalKey();
    GlobalKey dropdownKey2 = GlobalKey();
    FocusNode n = FocusNode();
    FocusNode n1 = FocusNode();
    FocusNode fnButton = FocusNode();

    return Container(
      child: Container(
        // padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Shortcuts(
            shortcuts: const <ShortcutActivator, Intent>{
              // Pressing space in the field will now move to the next field.
              //   SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
            },
            child: FocusTraversalGroup(
              child: Wrap(children: [
                Obx(() => EHTextField(
                      key: textKey1,
                      // autoFocus: true,
                      controller: EHTextFieldController(
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
                      key: textKey2,
                      text: controller.receiptModel.value.receiptKey,
                      controller: EHTextFieldController(
                          label: '测试2',
                          //errorBucket: controller.errorBucket,
                          text: controller.receiptModel.value.receiptKey,
                          mustInput: true,
                          onChanged: (value) =>
                              controller.receiptModel.update((model) {
                                model!.receiptKey = value;
                              })),
                    )),
                Obx(
                  () => EHTextField(
                      focusNode: n,
                      label: controller.receiptModel.value.receiptKey,
                      text: controller.receiptModel.value.receiptKey,
                      errorBucket: controller.errorBucket,
                      mustInput: true,
                      width: 300,
                      onChanged: (value) {
                        controller.receiptModel.update((model) {
                          model!.receiptKey = value;
                        });
                        n.requestFocus();
                      }),
                ),
                Obx(() => EHDropdown(
                      focusNode: n1,
                      key: dropdownKey1,
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
                      }),
                    )),
                Obx(() => EHDropdown(
                      key: dropdownKey2,
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
                      }),
                    )),
                Obx(
                  () => EHTextField(
                    label: controller.receiptModel.value.receiptKey,
                    text: controller.receiptModel.value.receiptKey,
                    errorBucket: controller.errorBucket,
                    mustInput: true,
                    width: 300,
                    onChanged: (value) {
                      controller.receiptModel.update((model) {
                        model!.receiptKey = value;
                      });
                    },
                    // onEditingComplete: (c) {
                    //   // Move the focus to the next node explicitly.
                    //   //FocusScope.of(c).(fnText);

                    //   //  n1.requestFocus();
                    //   //  FocusTraversalGroup.of(context!).next(fnText);
                    // },
                  ),
                ),
                Obx(() => EHPopup(
                      key: popupKey1,
                      // autoFocus: true,
                      controller: EHPopupController(
                          codeColumnName: 'customerId',
                          dataGridSource: DataGridTest.getDataGridSource(),
                          label: '测试1',
                          text: controller.receiptModel.value.customerId,
                          mustInput: true,
                          //  autoFocus: true,
                          onChanged: (code, row) =>
                              controller.receiptModel.update((model) {
                                model!.customerId = code;
                                model!.customerName = row['name'];
                              })),
                    )),
                Obx(
                  () => EHTextField(
                    //enabled: false,
                    label: controller.receiptModel.value.customerName,
                    text: controller.receiptModel.value.customerName,
                    errorBucket: controller.errorBucket,
                    mustInput: true,
                    width: 300,
                    onChanged: (value) {
                      controller.receiptModel.update((model) {
                        model!.customerName = value;
                      });
                    },
                    // onEditingComplete: (c) {
                    //   // Move the focus to the next node explicitly.
                    //   //FocusScope.of(c).(fnText);

                    //   //  n1.requestFocus();
                    //   //  FocusTraversalGroup.of(context!).next(fnText);
                    // },
                  ),
                ),
                ElevatedButton(
                  focusNode: fnButton,
                  onPressed: () {
                    EHToastMessageHelper.showInfoMessage(
                        MediaQuery.of(context).viewInsets.bottom.toString());
                  },
                  child: Text('verify'),
                )
              ]),
            )),
      ),
    );
  }
}
