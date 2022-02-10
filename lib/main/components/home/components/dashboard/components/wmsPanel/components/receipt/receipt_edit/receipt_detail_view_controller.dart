import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ReceiptDetailViewController extends EHController {
  RxString textData = ''.obs;
  RxString errorMsg = 'aaa'.obs;
  TextEditingController textController = TextEditingController();
}
