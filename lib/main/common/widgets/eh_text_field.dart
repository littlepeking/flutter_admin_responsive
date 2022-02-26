import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHTextField extends EHStatelessWidget<EHTextFieldController> {
  EHTextField({
    required Key key,
    required EHTextFieldController controller,
  }) : super(key: key, controller: controller);

  Future<bool> _validate() async {
    bool isValid = controller.checkMustInput(key!, controller.text);

    if (!isValid) return false;

    isValid = await controller.validate();

    if (!isValid && EHUtilHelper.isEmpty(controller.errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    if (controller.errorBucket == null)
      controller.errorBucket = EHController.globalErrorBucket;
    return Obx(() => Container(
          padding: LayoutConstant.defaultEditWidgetPadding,
          // height: 70,
          width: controller.width,
          child: Column(
            children: [
              EHEditLabel(
                mustInput: controller.mustInput,
                label: controller.label,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 25,
                      child: TextField(
                        // keyboardType: TextInputType.number,
                        // inputFormatters: <TextInputFormatter>[
                        //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        // ],
                        autofocus: controller.autoFocus,
                        focusNode: controller.focusNode,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintStyle: TextStyle().copyWith(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .fontSize),
                          hintText: controller.textHint,
                          contentPadding: EdgeInsets.all(5),
                          border: new OutlineInputBorder(),
                        ),
                        controller: controller._textEditingController,
                        enabled: controller.enabled,
                        // onEditingComplete: () {
                        //   // Move the focus to the next node explicitly.
                        //   if (controller.onEditingComplete == null) {
                        //     FocusScope.of(context).nextFocus();
                        //   } else {
                        //     controller.onEditingComplete!(context);
                        //   }
                        // },

                        // onChanged: (v) {
                        //   if (controller.mustInput) {
                        //     if (EHUtilHelper.isEmpty(v)) {
                        //       controller.errorBucket![key] =
                        //           'This field cannot be empty'.tr;
                        //     } else {
                        //       controller.errorBucket![key] = '';
                        //     }
                        //   }
                        //   controller.onChanged!(v);
                        // },
                        // onSubmitted: (v) {
                        //   print(v);
                        // },
                        onEditingComplete: () async {
                          if (!await _validate()) return;
                          if (controller.onChanged != null)
                            controller.onChanged!(controller.text);
                          controller.focusNode.nextFocus();
                        },
                      ),
                    ),
                  ),
                  controller.afterWidget ?? SizedBox()
                ],
              ),
              Obx(() => EHEditErrorInfo(
                  errorBucket: controller.errorBucket!.value,
                  errorFieldKey: key))
            ],
          ),
        ));
  }
}

class EHTextFieldController extends EHEditWidgetController {
  EHTextEditingController _textEditingController =
      new EHTextEditingController();

  set text(val) {
    this._textEditingController.text = val;
  }

  String get text {
    return _textEditingController.text;
  }

  ValueChanged<String>? onChanged;

  Widget? afterWidget;

  String textHint;

  EHTextFieldController(
      {double? width,
      bool autoFocus = false,
      required FocusNode focusNode,
      String label = '',
      String text = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      Future<bool> Function()? validate,
      Map<Key?, String>? errorBucket,
      this.afterWidget,
      this.textHint = ''})
      : super(
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    this.validate = validate ?? () async => true;
    this.text = text;
  }
}

class EHTextEditingController extends TextEditingController {
  @override
  set text(String newText) {
    //resolve  cursor always at first position issue cause by obx.
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  EHTextEditingController({String text = ''}) : super(text: text);
}
