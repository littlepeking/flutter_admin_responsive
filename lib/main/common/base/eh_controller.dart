import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHController extends GetxController {
  static Map<Key, RxString> globalErrorBucket = {
    GlobalKey(debugLabel: '_eh_global_error_'): '__eh_global_error__'.obs
  };

  static Map<Key, RxString> globalDisplayValueBucket = {
    GlobalKey(debugLabel: '_eh_global_displayValue_'):
        '_eh_global_displayValue_'.obs
  };

  static setWidgetDisplayValue(Key key, String displayValue) {
    if (EHController.globalDisplayValueBucket[key] == null)
      EHController.globalDisplayValueBucket[key] = ''.obs;

    EHController.globalDisplayValueBucket[key]!.value = displayValue;
  }

  static getWidgetDisplayValue(Key key) {
    if (EHController.globalDisplayValueBucket[key] == null)
      EHController.globalDisplayValueBucket[key] = ''.obs;

    return EHController.globalDisplayValueBucket[key]!.value;
  }

  static setWidgetError(
      Map<Key?, RxString> errorBucket, Key key, String errorMsg) {
    if (errorBucket[key] == null) errorBucket[key] = ''.obs;

    errorBucket[key]!.value = errorMsg;
  }

  static String getWidgetError(Map<Key?, RxString> errorBucket, Key key) {
    if (errorBucket[key] == null) errorBucket[key] = ''.obs;

    return errorBucket[key]!.value;
  }
}
