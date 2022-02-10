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
                EHTextField(
                    label: '测试',
                    text: controller.receiptModel.value.receiptKey,
                    mustInput: true,
                    onChanged: (value) =>
                        controller.receiptModel.update((model) {
                          model!.receiptKey = value;
                          print(model.receiptKey + '===' + model.customerName);
                        })),
                EHTextField(
                  label: '测试',
                  text: controller.receiptModel.value.customerName,
                  mustInput: false,
                  width: 300,
                  onChanged: (value) => controller.receiptModel.update((model) {
                    model!.customerName = value;
                    print(model.receiptKey + '===' + model.customerName);
                  }),
                ),
                EHTextField(
                  label: '',
                  text: '',
                  enabled: false,
                  mustInput: true,
                  onChanged: (value) => print(value),
                ),
                EHTextField(
                  label: '测试',
                  text: '',
                  mustInput: true,
                  onChanged: (value) => print(value),
                ),
                EHTextField(
                  label: '测试',
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
