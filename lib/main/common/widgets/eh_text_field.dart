import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/constants/layout_constant.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/eh_refactor_helper.dart';

class EHTextField extends EHEditableWidget<EHTextFieldController> {
  EHTextField({
    required EHTextFieldController controller,
  }) : super(key: controller.key, controller: controller);

  @override
  Widget build(BuildContext context) {
    if (controller.errorBucket == null)
      controller.errorBucket = EHController.globalErrorBucket;

    late List<TextInputFormatter> inputFormatters;
    late TextInputType keyboardType;
    if (controller.type == EHTextInputType.Text) {
      inputFormatters = [];
      if (controller.maxLines > 1) {
        keyboardType = TextInputType.multiline;
      } else {
        keyboardType = TextInputType.text;
      }
    } else if (controller.type == EHTextInputType.Int) {
      inputFormatters =
          inputFormatters = [FilteringTextInputFormatter.digitsOnly];
      keyboardType = TextInputType.number;
    } else if (controller.type == EHTextInputType.Double) {
      inputFormatters = [
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
      ];

      keyboardType = TextInputType.numberWithOptions(decimal: true);
    }

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
                      height: controller.maxLines == 1 ? 25 : null,
                      child: Focus(
                        descendantsAreFocusable: true,
                        canRequestFocus: false,
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus) {
                            if (!controller.isValidated) {
                              await doValidateAndUpdateModel(false);
                            }
                            controller.isValidated = false;
                          }
                        },
                        child: TextField(
                          keyboardType: keyboardType,
                          inputFormatters: inputFormatters,
                          autofocus: controller.autoFocus,
                          focusNode: controller.focusNode,
                          textInputAction: TextInputAction.next,
                          maxLines: controller.maxLines,
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
                            await doValidateAndUpdateModel(true);
                            controller.isValidated = true;
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

  doValidateAndUpdateModel(bool goNextFocusIfValid) async {
    if (await controller._validate()) {
      EHController.setWidgetDisplayValue(controller.key!, '');

      late Object? value;
      if (controller.type == EHTextInputType.Int) {
        value = controller.displayValue == ''
            ? null
            : int.parse(controller.displayValue);
      } else if (controller.type == EHTextInputType.Double) {
        value = controller.displayValue == ''
            ? null
            : double.parse(controller.displayValue);
      } else {
        value = controller.displayValue;
      }
      if (controller.setModelValue(value) ||
          controller.model == null ||
          controller.bindingFieldName == null) {
        if (controller.onChanged != null)
          controller.onChanged!(controller.displayValue);
      }

      if (goNextFocusIfValid) controller.focusNode!.nextFocus();
    } else {
      EHController.setWidgetDisplayValue(
          controller.key!, controller.displayValue);
    }
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

  bool isValidated = false;

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

  EHTextInputType type;

  int maxLines;

  EHTextFieldController(
      {this.key,
      double? width,
      this.maxLines = 1,
      bool autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      String bindingValue = '',
      bool enabled = true,
      bool mustInput = false,
      this.type = EHTextInputType.Text,
      EHModel? model,
      String? bindingFieldName,
      this.onChanged,
      EHEditableWidgetOnValidate? onValidate,
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
            errorBucket: errorBucket,
            onValidate: onValidate) {
    this._bindingValue = bindingValue;

    init();
  }

  @override
  init() {
    String? value;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      Object? v = EHRefactorHelper.getFieldValue(model!, bindingFieldName!);
      value = v == null ? '' : v.toString();
    } else {
      value = _bindingValue;
    }

    if (key != null &&
        !EHUtilHelper.isEmpty(EHController.getWidgetDisplayValue(key!))) {
      displayValue = EHController.getWidgetDisplayValue(key!);
    } else {
      this.displayValue = value;
    }

    // super.init();
  }

  Future<bool> _validate() async {
    bool isValid = checkMustInput(key!, displayValue);

    if (!isValid) return false;

    isValid = await onValidate(this);

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

enum EHTextInputType { Int, Double, Text }

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
