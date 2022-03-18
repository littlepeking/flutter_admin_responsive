import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHController extends GetxController {
  static RxMap<Key, String> globalErrorBucket =
      {GlobalKey(debugLabel: '_eh_global_error_'): '__eh_global_error__'}.obs;

  static Map<Key, RxString> globalDisplayValueBucket = {
    GlobalKey(debugLabel: '_eh_global_displayValue_'):
        '_eh_global_displayValue_'.obs
  };

  static setWidgetDisplayValue(Key key, String errorMsg) {
    if (EHController.globalDisplayValueBucket[key] == null) {
      EHController.globalDisplayValueBucket[key] = ''.obs;
    }
    EHController.globalDisplayValueBucket[key]!.value = errorMsg;
  }

  static getWidgetDisplayValue(Key key) {
    if (EHUtilHelper.isEmpty(EHController.globalDisplayValueBucket[key])) {
      return '';
    }
    return EHController.globalDisplayValueBucket[key]!.value;
  }
}
