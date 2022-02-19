import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHController extends GetxController {
  static RxMap<Key, String> globalErrorBucket =
      {GlobalKey(debugLabel: '_global_error_'): '__global_error__'}.obs;
}
