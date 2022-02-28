import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHController extends GetxController {
  static RxMap<Key, String> globalErrorBucket =
      {GlobalKey(debugLabel: '_eh_global_error_'): '__eh_global_error__'}.obs;
}
