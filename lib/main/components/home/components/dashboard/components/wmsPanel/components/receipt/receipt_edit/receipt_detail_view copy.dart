import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
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
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Shortcuts(
            shortcuts: const <ShortcutActivator, Intent>{
              // Pressing space in the field will now move to the next field.
              SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
            },
            child: FocusTraversalGroup(
                child: Form(
              key: editFormKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              child: Wrap(children: [
                Container(
                    height: 30,
                    width: 200,
                    child: TextField(
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextField(
                      controller: controller.textController,
                      onChanged: (String? value) {},
                      maxLines: null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      initialValue: controller.textData.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (String? value) {
                        controller.textData.value = value!;
                      },
                      onSaved: (String? value) {
                        debugPrint('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      controller: controller.textController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (String? value) {},
                      onSaved: (String? value) {
                        debugPrint('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      onChanged: (String? value) {},
                      onSaved: (String? value) {
                        print('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      onChanged: (String? value) {},
                      onSaved: (String? value) {
                        debugPrint('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      onChanged: (String? value) {},
                      onSaved: (String? value) {
                        debugPrint('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      onChanged: (String? value) {},
                      onSaved: (String? value) {
                        debugPrint('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 60)),
                    child: TextFormField(
                      onChanged: (String? value) {},
                      onSaved: (String? value) {
                        debugPrint('Value for field saved as "$value"');
                      },
                      maxLines: null,
                      validator: (value) =>
                          value!.contains('@') ? null : 'wrong email',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    editFormKey.currentState!.validate();
                  },
                  child: Text('verify'),
                )
              ]),
            ))),
      )),
    );
  }
}
