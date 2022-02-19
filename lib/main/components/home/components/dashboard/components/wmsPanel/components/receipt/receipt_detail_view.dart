import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(children: [
                    Obx(() => EHTextField(
                          key: controller.textKey1,
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
                          key: controller.textKey2,
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
                    Obx(() => EHPopup(
                          key: controller.popupKey1,
                          // autoFocus: true,
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
                    Obx(
                      () => EHTextField(
                          key: controller.textKey3,
                          focusNode: controller.n,
                          label: controller.receiptModel.value.receiptKey,
                          text: controller.receiptModel.value.receiptKey,
                          errorBucket: controller.errorBucket,
                          mustInput: true,
                          width: 300,
                          onChanged: (value) {
                            controller.receiptModel.update((model) {
                              model!.receiptKey = value;
                            });
                            controller.n.requestFocus();
                          }),
                    ),
                    Obx(() => EHDropdown(
                          key: controller.dropdownKey1,
                          controller: EHDropDownController(
                              validate: () async => true,
                              focusNode: controller.n1,
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
                  ]),
                ],
              ),
            )),
      ),
    );
  }
}
