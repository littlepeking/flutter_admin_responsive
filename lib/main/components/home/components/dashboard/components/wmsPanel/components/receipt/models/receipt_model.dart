import 'dart:convert';
import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/EHModel.dart';

import '../../../../../../../../../common/utils/EHRefactorHelper.dart';

@methodExecutor
class ReceiptModel extends EHModel {
  String receiptKey;
  String? customerId;
  String customerName;

  String dropdownValue;
  String dropdownValue2;
  List<String> multiSelectValues;
  DateTime? dateTime;
  DateTime? dateTime2;
  ReceiptModel({
    required this.receiptKey,
    required this.customerId,
    required this.customerName,
    required this.dropdownValue,
    required this.dropdownValue2,
    required this.multiSelectValues,
    required this.dateTime,
    required this.dateTime2,
  });

  String toJsonStr() => jsonEncode({
        'receiptKey': receiptKey,
        'customerId': customerId,
        'customerName': customerName,
        'dropdownValue': dropdownValue,
        'multiSelectValues': multiSelectValues.toString(),
        'dateTime': dateTime.toString(),
        'dateTime2': dateTime2.toString(),
      });
}
