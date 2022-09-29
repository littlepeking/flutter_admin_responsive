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

import 'dart:async';

import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_controller.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/base/eh_model.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/utils/eh_refactor_helper.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef Future<bool> EHEditableWidgetOnValidate<
    S extends EHEditableWidgetController>(S controller);

abstract class EHEditableWidgetController<T extends EHModel>
    extends EHController {
  EHEditableWidgetController(
      {this.model,
      this.bindingFieldName,
      this.width,
      bool mustInput = false,
      String label = '',
      bool enabled = true,
      bool autoFocus = false,
      this.focusNode,
      this.key,
      EHEditableWidgetOnValidate? onValidate,
      Map<Key?, RxString>? errorBucket}) {
    this.width = width ?? LayoutConstant.editWidgetSize;
    this.onValidate =
        onValidate ?? (EHEditableWidgetController controller) async => true;
    this.label = label;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.autoFocus = autoFocus;
    this.errorBucket =
        (errorBucket == null ? EHController.globalErrorBucket : errorBucket);
  }

  Function? notifyChanged;

  late Key? key;

  FocusNode? focusNode;

  T? model;

  Rx<T>? rxModel;

  String? bindingFieldName;

  late EHEditableWidgetOnValidate onValidate;

  double? width;

  RxString _label = ''.obs;

  String get label {
    return _label.value;
  }

  set label(v) {
    _label.value = v ?? '';
  }

  RxBool _enabled = true.obs;

  get enabled {
    return _enabled.value;
  }

  set enabled(v) {
    _enabled.value = v ?? true;
  }

  RxBool _mustInput = false.obs;

  get mustInput {
    return _mustInput.value;
  }

  set mustInput(v) {
    _mustInput.value = v ?? false;
  }

  RxBool _autoFocus = false.obs;

  get autoFocus {
    return _autoFocus.value;
  }

  set autoFocus(v) {
    _autoFocus.value = v ?? false;
  }

  Map<Key?, RxString>? errorBucket;

  Future<bool> validateWidget();

  bool checkMustInput(Key key, text, {String emptyValue = ''}) {
    if (mustInput) {
      if (text is List && text.length == 0 ||
          text is String &&
              (EHUtilHelper.isEmpty(text) || text == emptyValue)) {
        EHController.setWidgetError(
            errorBucket!, key, 'common.error.fieldNotEmpty'.tr);

        return false;
      } else {
        EHController.setWidgetError(errorBucket!, key, '');

        return true;
      }
    }

    return true;
  }

  setModelValue(value) {
    if (model != null && bindingFieldName != null) {
      EHRefactorHelper.setFieldValue(model!, bindingFieldName!, value);
      rxModel!.refresh();
    }
  }

  void init() {
    // StreamSubscription? streamSubscription;
    // if (rxModel != null) {
    //   streamSubscription = rxModel!.listen((event) {
    //     print((event as ReceiptModel).toJsonStr());
    //     streamSubscription!.cancel();
    //   });
    // }
  }

  void clearWidgetInfo() {
    EHController.clearError(errorBucket!, key!);
    EHController.clearDisplayValue(key!);
  }
}
