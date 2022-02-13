import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
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
    GlobalKey dropdownKey1 = GlobalKey();
    GlobalKey dropdownKey2 = GlobalKey();
    FocusNode fn1 = FocusNode();

    FocusNode fn2 = FocusNode();
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
                      focusNode: fn1,
                      key: textKey1,
                      autoFocus: true,
                      text: controller.receiptModel.value.receiptKey,
                      controller: EHTextFieldController(
                          label: '测试1',
                          text: controller.receiptModel.value.receiptKey,
                          mustInput: true,
                          autoFocus: true,
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
                      onChanged: (value) {
                        controller.receiptModel.update((model) {
                          model!.receiptKey = value;
                        });
                        // fn1.requestFocus();
                      }),
                ),
                Obx(() => EHDropdown(
                      key: dropdownKey1,
                      label: '测试4',
                      mustInput: true,
                      selectedValue:
                          controller.receiptModel.value.dropdownValue,
                      items: {
                        '0': 'Item0',
                        '1': 'Item1',
                        '2': 'Item2',
                        '3': 'Item222',
                        '4': 'Item23',
                        '5': 'Item0',
                        '6': 'Item1',
                        '7': 'Item2',
                        '8': 'Item222',
                        '9': 'Item23',
                        '10': 'Item0',
                        '11': 'Item1',
                        '12': 'Item2',
                        '13': 'Item222',
                        '14': 'Item23',
                        '20': 'Item0',
                        '21': 'Item1',
                        '22': 'Item2',
                        '23': 'Item222',
                        '24': 'Item23',
                        '25': 'Item0',
                        '26': 'Item1',
                        '27': 'Item2',
                        '28': 'Item222',
                        '29': 'Item23',
                        '110': 'Item0',
                        '111': 'Item1',
                        '112': 'Item2',
                        '113': 'Item222',
                        '114': 'Item23',
                        '120': 'Item0',
                        '121': 'Item1',
                        '122': 'Item2',
                        '123': 'Item222',
                        '124': 'Item23',
                        '125': 'Item0',
                        '126': 'Item1',
                        '127': 'Item2',
                        '128': 'Item222',
                        '129': 'Item23',
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
                      onChanged: (value) =>
                          controller.receiptModel.update((model) {
                            model!.receiptKey = value;
                          })),
                ),
                ElevatedButton(
                  onPressed: () {
                    EHToastMessageHelper.showInfoMessage(
                        MediaQuery.of(context).viewInsets.bottom.toString());
                  },
                  child: Text('verify'),
                )
              ]),
            )),
      )),
    );
  }
}
