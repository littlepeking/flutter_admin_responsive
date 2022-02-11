import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'receipt_detail_view_controller.dart';

class ReceiptDetailView extends EHStatelessWidget<ReceiptDetailViewController> {
  ReceiptDetailView({Key? key, controller})
      : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
    GlobalKey textKey1 = GlobalKey();
    GlobalKey textKey2 = GlobalKey();
    return Container(
      child: SingleChildScrollView(
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
                      text: controller.receiptModel.value.receiptKey,
                      controller: EHTextFieldController(
                          label: '测试1',
                          text: controller.receiptModel.value.receiptKey,
                          mustInput: true,
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
                      label: controller.receiptModel.value.receiptKey,
                      text: controller.receiptModel.value.receiptKey,
                      errorBucket: controller.errorBucket,
                      mustInput: true,
                      width: 300,
                      onChanged: (value) =>
                          controller.receiptModel.update((model) {
                            model!.receiptKey = value;
                          })),
                ),
                EHTextField(
                  label: '测试4',
                  text: '',
                  mustInput: true,
                  onChanged: (value) => print(value),
                ),
                ElevatedButton(
                  onPressed: () {
                    editFormKey.currentState!.validate();
                  },
                  child: Text('verify'),
                )
              ]),
            )),
      )),
    );
  }
}
