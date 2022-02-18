import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/EHModel.dart';

class ReceiptModel extends EHModel {
  String receiptKey;
  String customerId;
  String customerName;

  String dropdownValue;
  ReceiptModel(
      {required this.receiptKey,
      required this.customerId,
      required this.customerName,
      required this.dropdownValue});
}
