import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHEditWidgetController extends EHController {
  EHEditWidgetController(
      {this.width = LayoutConstant.editWidgetSize,
      bool mustInput = false,
      String label = '',
      bool enabled = true,
      bool autoFocus = false,
      this.focusNode,
      Future<bool> Function()? validate,
      Map<Key?, String>? errorBucket}) {
    this.validate = validate ?? () async => true;
    this.label = label;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.autoFocus = autoFocus;
    this.errorBucket = (errorBucket == null
        ? EHController.globalErrorBucket
        : errorBucket.obs);
  }

  late Future<bool> Function() validate;

  double? width;

  RxString _label = ''.obs;

  get label {
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

  RxMap<Key?, String>? errorBucket;

  FocusNode? focusNode;

  bool checkMustInput(Key key, text, {String emptyValue = ''}) {
    if (mustInput) {
      if (EHUtilHelper.isEmpty(text) || text == emptyValue) {
        errorBucket![key] = 'This field cannot be empty'.tr;
        return false;
      } else {
        errorBucket![key] = '';
        return true;
      }
    }

    return true;
  }
}
