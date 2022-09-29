/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_edit_widget_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_editable_widget.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_model.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/common/eh_edit_error_info.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../enhantec_ui_framework/utils/eh_refactor_helper.dart';

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
              controller.showLabel
                  ? EHEditLabel(
                      mustInput: controller.mustInput,
                      label: controller.label.tr,
                    )
                  : SizedBox(),
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
                              await controller.doValidateAndUpdateModel(false);
                            }
                            controller.isValidated = false;
                          }
                        },
                        child: TextField(
                          obscureText: controller.hideText,
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
                                    .bodyLarge!
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

                          onChanged: (v) async {
                            //
                            if (controller.onChanged != null) {
                              if (await controller
                                  .doValidateAndUpdateModel(false)) {
                                controller.onChanged!(v);
                              }
                            }
                          },
                          // onSubmitted: (v) {
                          //   //  print(v);
                          // },
                          onEditingComplete: () async {
                            await controller.doValidateAndUpdateModel(true);
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
              controller.showErrorInfo
                  ? Obx(() => EHEditErrorInfo(
                      // ignore: invalid_use_of_protected_member
                      error: EHController.getWidgetError(
                          controller.errorBucket!, key!)))
                  : SizedBox()
              // Obx(() {
              //   return EHEditErrorInfo(
              //       // ignore: invalid_use_of_protected_member
              //       error: controller.errorBucket![key] == null
              //           ? ''
              //           : controller.errorBucket![key]!.value);
              // }),
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

  bool isValidated = false;

  // set bindingValue(String val) {
  //   _bindingValue = val;
  // }

  // String get bindingValue {
  //   return _bindingValue;
  // }

  ValueChanged<String>? onEditingComplete;

  ValueChanged<String>? onChanged;

  Widget? afterWidget;

  String textHint;

  Key? key;

  EHTextInputType type;

  int maxLines;

  bool showLabel;

  bool showErrorInfo;

  bool goNextAfterComplete;

  bool hideText;

  EHTextFieldController(
      {this.key,
      this.hideText = false,
      double? width,
      this.maxLines = 1,
      bool autoFocus = false,
      FocusNode? focusNode,
      String labelMsgKey = '',
      String bindingValue = '',
      bool enabled = true,
      bool mustInput = false,
      this.type = EHTextInputType.Text,
      EHModel? model,
      String? bindingFieldName,
      this.onEditingComplete,
      this.onChanged, //Please only use 'onChanged' when we input a character and immediately need calculate some related values to avoid unnecessary performance cost. normally use onEditingComplete instead.
      EHEditableWidgetOnValidate? onValidate,
      Map<Key?, RxString>? errorBucket,
      this.afterWidget,
      this.textHint = '',
      this.showErrorInfo = true,
      this.showLabel = true,
      this.goNextAfterComplete = true})
      : super(
            model: model,
            bindingFieldName: bindingFieldName,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: labelMsgKey,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket,
            onValidate: onValidate) {
    this._bindingValue = bindingValue;

    init();
  }

  @override
  init() {
    String? value = getInitValue();

    //if exists Widget Error means displayValue should be used even it is empty. e.g.must input error
    if (key != null &&
        (!EHUtilHelper.isEmpty(EHController.getWidgetDisplayValue(key!)) ||
            !EHUtilHelper.isEmpty(
                EHController.getWidgetError(errorBucket!, key!)))) {
      displayValue = EHController.getWidgetDisplayValue(key!);
    } else {
      this.displayValue = value;
    }

    // super.init();
  }

  String getInitValue() {
    String? value;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      Object? v = EHRefactorHelper.getFieldValue(model!, bindingFieldName!);
      value = v == null ? '' : v.toString();
    } else {
      value = _bindingValue;
    }

    return value;
  }

  Future<bool> _validate() async {
    EHController.setWidgetDisplayValue(key!, displayValue);
    EHController.setWidgetError(errorBucket!, key!, '');
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
    //Need update model here to make sure validated display data sync to the data model to resolve android and ios issue that model data cannot be updated after change form data and click 'save' button directly.
    return await doValidateAndUpdateModel(false);
  }

  //return value: if valid
  Future<bool> doValidateAndUpdateModel(bool goNextFocusIfValid) async {
    if (await _validate()) {
      Object? newValue;
      if (type == EHTextInputType.Int) {
        newValue = displayValue == '' ? null : int.parse(displayValue);
      } else if (type == EHTextInputType.Double) {
        newValue = displayValue == '' ? null : double.parse(displayValue);
      } else {
        newValue = displayValue;
      }

      String newValueStr = newValue == null ? '' : newValue.toString();

      if (getInitValue() != newValueStr) {
        setModelValue(newValue);
        if (onEditingComplete != null) onEditingComplete!(displayValue);
      }

      clearWidgetInfo();

      if (goNextFocusIfValid && goNextAfterComplete) focusNode!.nextFocus();

      return true;
    } else {
      return false;
    }
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
