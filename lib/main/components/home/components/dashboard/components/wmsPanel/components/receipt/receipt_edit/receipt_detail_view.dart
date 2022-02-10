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
        // padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Shortcuts(
            shortcuts: const <ShortcutActivator, Intent>{
              // Pressing space in the field will now move to the next field.
              SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
            },
            child: FocusTraversalGroup(
                child: Form(
              //autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: new OutlineInputBorder(),
                      hintText: "Filter...".tr,
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 200,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: new OutlineInputBorder(),
                      hintText: "Filter...".tr,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: Obx(() => Container(
                          height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              errorMaxLines: 1,
                              errorText: controller.errorMsg.value == ''
                                  ? null
                                  : controller.errorMsg.value,
                              errorStyle: TextStyle(height: 1),
                              hintText: "Filter...111",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: controller.textData.value,
                            onChanged: (String? value) {
                              controller.textData.value = value!;
                            },
                            maxLines: null,
                            validator: (value) =>
                                value!.contains('@') ? null : 'wrong email',
                          ),
                        )),
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
                    child: Obx(() => TextFormField(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            errorMaxLines: 1,
                            errorText: controller.errorMsg.value,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: controller.errorMsg.value,
                          onChanged: (String? value) {
                            controller.errorMsg.value = value!;
                          },
                          maxLines: null,
                          validator: (value) =>
                              value!.contains('@') ? null : 'wrong email',
                        )),
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
