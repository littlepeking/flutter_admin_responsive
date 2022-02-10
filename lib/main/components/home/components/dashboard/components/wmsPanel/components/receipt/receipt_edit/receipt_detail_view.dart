import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/receipt_edit/receipt_detail_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
                  text: 'defval',
                  mustInput: true,
                  onChanged: (value) => print(value),
                ),
                EHTextField(
                  label: '测试',
                  text: '',
                  mustInput: false,
                  width: 300,
                  onChanged: (value) => print(value),
                ),
                EHTextField(
                  label: '',
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
