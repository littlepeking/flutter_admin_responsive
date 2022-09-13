import 'dart:convert';
import 'dart:core';

import 'package:eh_flutter_framework/main/common/base/eh_model_converters.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:eh_flutter_framework/main/common/base/eh_model.dart';

import '../../../../../../../../../common/utils/eh_refactor_helper.dart';

part 'receipt_model.g.dart';

@JsonSerializable()
@EHMethodExecutor
@EHDateTime2TimeStampConverter
@EHList2StringConverter
class ReceiptModel extends EHModel {
  String? receiptKey;
  int? num1;
  double? num2;
  String? customerId;
  String customerName;

  String dropdownValue;
  String dropdownValue2;
  String dropdownValue3;
  List<String> multiSelectValues;

  //@EHDateTime2TimeStampConverter()
  DateTime? dateTime;
  DateTime? dateTime2;
  bool? isChecked;
  ReceiptModel({
    required this.receiptKey,
    required this.num1,
    required this.num2,
    required this.customerId,
    required this.customerName,
    required this.dropdownValue,
    required this.dropdownValue2,
    required this.dropdownValue3,
    required this.multiSelectValues,
    required this.dateTime,
    required this.dateTime2,
    this.isChecked,
  });

  factory ReceiptModel.fromJson(Map<String, dynamic> json) =>
      _$ReceiptModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReceiptModelToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return ReceiptModel.fromJson(json);
  }

  String toJsonStr() => jsonEncode(toJson());
}
