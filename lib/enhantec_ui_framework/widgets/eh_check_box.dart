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

import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_model.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../enhantec_ui_framework/utils/eh_refactor_helper.dart';

class EHCheckBox extends EHEditableWidget<EHCheckBoxController> {
  EHCheckBox({
    required EHCheckBoxController controller,
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
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      height: 25,
                      child: Focus(
                        descendantsAreFocusable: true,
                        canRequestFocus: false,
                        // onFocusChange: (hasFocus) async {
                        //   if (!hasFocus) {
                        //     await controller._validate();

                        //     controller.setModelValue(controller.text);

                        //     if (controller.onChanged != null)
                        //       controller.onChanged!(controller.text);
                        //   }
                        // },
                        child: Checkbox(
                            focusNode: controller.focusNode,
                            value: controller.checkValue,
                            tristate: false,
                            onChanged: controller.enabled
                                ? (value) {
                                    controller.setModelValue(value);
                                    controller.focusNode!.requestFocus();
                                    controller.focusNode!.nextFocus();

                                    if (controller.onChanged != null)
                                      controller.onChanged!(value ?? false);
                                  }
                                : null),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => EHEditErrorInfo(
                  // ignore: invalid_use_of_protected_member
                  error: EHController.getWidgetError(
                      controller.errorBucket!, key!))),
            ],
          ),
        ));
  }
}

class EHCheckBoxController extends EHEditableWidgetController {
  ValueChanged<bool>? onChanged;
  EHCheckBoxController(
      {Key? key,
      double? width,
      bool autoFocus = false,
      FocusNode? focusNode,
      String labelMsgKey = '',
      bool? bindingValue,
      bool enabled = true,
      bool mustInput = false,
      EHModel? model,
      String? bindingFieldName,
      this.onChanged,
      EHEditableWidgetOnValidate? onValidate,
      Map<Key?, RxString>? errorBucket})
      : super(
            key: key,
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
    //Check if exists ehEditForm first
    this._bindingValue = bindingValue;

    init();
  }

  late bool? _bindingValue;

  late bool checkValue;

  @override
  init() {
    bool? value;
    if (model != null && bindingFieldName != null) {
      value =
          EHRefactorHelper.getFieldValue(model!, bindingFieldName!) as bool?;
    } else {
      value = _bindingValue;
    }

    this.checkValue = value ?? false;
  }

  Future<bool> _validate() async {
    bool isValid = await onValidate(this);

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
