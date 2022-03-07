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
                  errorBucket: controller.errorBucket!.value,
                  errorFieldKey: key))
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
      String label = '',
      bool? bindingValue,
      bool enabled = true,
      bool mustInput = false,
      EHModel? model,
      String? bindingFieldName,
      this.onChanged,
      Future<bool> Function()? validate,
      Map<Key?, String>? errorBucket})
      : super(
            key: key,
            model: model,
            bindingFieldName: bindingFieldName,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    //Check if exists ehEditForm first
    this._bindingValue = bindingValue;

    init();

    this.validate = validate ?? () async => true;
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
    bool isValid = await validate();

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
