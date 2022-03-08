import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditableWidget.dart';
import 'package:eh_flutter_framework/main/common/base/EHModel.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/EHRefactorHelper.dart';

class EHTextField extends EHEditableWidget<EHTextFieldController> {
  EHTextField({
    required EHTextFieldController controller,
  }) : super(key: controller.key, controller: controller);

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
                label: controller.label.tr,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 25,
                      child: Focus(
                        descendantsAreFocusable: true,
                        canRequestFocus: false,
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus) {
                            if (await controller._validate()) {
                              EHController.globalDisplayValueBucket
                                  .remove(controller.key!);
                              controller.setModelValue(controller.displayValue);

                              if (controller.onChanged != null)
                                controller.onChanged!(controller.displayValue);
                            } else {
                              EHController.globalDisplayValueBucket[key!] =
                                  controller.displayValue;
                            }
                          }
                        },
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
                          onEditingComplete: () {
                            controller.focusNode!.nextFocus();
                            //controller.focusNode.unfocus();
                          },
                        ),
                      ),
                    ),
                  ),
                  controller.afterWidget ?? SizedBox()
                ],
              ),
              Obx(() => EHEditErrorInfo(
                  // ignore: invalid_use_of_protected_member
                  errorBucket: controller.errorBucket!.value,
                  errorFieldKey: key))
            ],
          ),
        ));
  }
}

class EHTextFieldController extends EHEditableWidgetController {
  EHTextEditingController _textEditingController =
      new EHTextEditingController();

  set displayValue(String val) {
    this._textEditingController.text = val;
  }

  String get displayValue {
    return _textEditingController.text;
  }

  late String _bindingValue;

  // set bindingValue(String val) {
  //   _bindingValue = val;
  // }

  // String get bindingValue {
  //   return _bindingValue;
  // }

  ValueChanged<String>? onChanged;

  Widget? afterWidget;

  String textHint;

  Key? key;

  EHTextFieldController(
      {this.key,
      double? width,
      bool autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      String bindingValue = '',
      bool enabled = true,
      bool mustInput = false,
      EHModel? model,
      String? bindingFieldName,
      this.onChanged,
      Future<bool> Function()? validate,
      Map<Key?, String>? errorBucket,
      this.afterWidget,
      this.textHint = ''})
      : super(
            model: model,
            bindingFieldName: bindingFieldName,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    this.validate = validate ?? () async => true;
    this._bindingValue = bindingValue;
    init();
  }

  @override
  init() {
    String? value;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      value =
          EHRefactorHelper.getFieldValue(model!, bindingFieldName!) as String?;
    } else {
      value = _bindingValue;
    }

    if (key != null && EHController.globalDisplayValueBucket[key] != null) {
      this.displayValue = EHController.globalDisplayValueBucket[key!]!;
    } else {
      this.displayValue = value ?? '';
    }

    // super.init();
  }

  Future<bool> _validate() async {
    bool isValid = checkMustInput(key!, displayValue);

    if (!isValid) return false;

    isValid = await validate();

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  Future<bool> validateWidget() async {
    return await _validate();
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
