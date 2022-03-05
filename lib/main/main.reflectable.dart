// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:eh_flutter_framework/main/common/base/EHModel.dart' as prefix1;
import 'package:eh_flutter_framework/main/common/utils/EHRefactorHelper.dart'
    as prefix0;
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart'
    as prefix2;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.MethodExecutor(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'EHModel',
            r'.EHModel',
            7,
            0,
            const prefix0.MethodExecutor(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix1.EHModel() : null},
            -1,
            -1,
            const <int>[-1],
            null,
            {
              r'==': 1,
              r'toString': 0,
              r'noSuchMethod': 1,
              r'hashCode': 0,
              r'runtimeType': 0
            }),
        r.NonGenericClassMirrorImpl(
            r'ReceiptModel',
            r'.ReceiptModel',
            7,
            1,
            const prefix0.MethodExecutor(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) => (
                      {receiptKey,
                      customerId,
                      customerName,
                      dropdownValue,
                      dropdownValue2,
                      multiSelectValues,
                      dateTime,
                      dateTime2,
                      isChecked}) =>
                  b
                      ? prefix2.ReceiptModel(
                          isChecked: isChecked,
                          customerId: customerId,
                          customerName: customerName,
                          dateTime: dateTime,
                          dateTime2: dateTime2,
                          dropdownValue: dropdownValue,
                          dropdownValue2: dropdownValue2,
                          multiSelectValues: multiSelectValues,
                          receiptKey: receiptKey)
                      : null
            },
            -1,
            -1,
            const <int>[-1],
            null,
            {
              r'==': 1,
              r'toString': 0,
              r'noSuchMethod': 1,
              r'hashCode': 0,
              r'runtimeType': 0,
              r'toJsonStr': 0,
              r'receiptKey': 0,
              r'receiptKey=': 1,
              r'customerId': 0,
              r'customerId=': 1,
              r'customerName': 0,
              r'customerName=': 1,
              r'dropdownValue': 0,
              r'dropdownValue=': 1,
              r'dropdownValue2': 0,
              r'dropdownValue2=': 1,
              r'multiSelectValues': 0,
              r'multiSelectValues=': 1,
              r'dateTime': 0,
              r'dateTime=': 1,
              r'dateTime2': 0,
              r'dateTime2=': 1,
              r'isChecked': 0,
              r'isChecked=': 1
            })
      ],
      null,
      null,
      <Type>[prefix1.EHModel, prefix2.ReceiptModel],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'toJsonStr': (dynamic instance) => instance.toJsonStr,
        r'receiptKey': (dynamic instance) => instance.receiptKey,
        r'customerId': (dynamic instance) => instance.customerId,
        r'customerName': (dynamic instance) => instance.customerName,
        r'dropdownValue': (dynamic instance) => instance.dropdownValue,
        r'dropdownValue2': (dynamic instance) => instance.dropdownValue2,
        r'multiSelectValues': (dynamic instance) => instance.multiSelectValues,
        r'dateTime': (dynamic instance) => instance.dateTime,
        r'dateTime2': (dynamic instance) => instance.dateTime2,
        r'isChecked': (dynamic instance) => instance.isChecked
      },
      {
        r'receiptKey=': (dynamic instance, value) =>
            instance.receiptKey = value,
        r'customerId=': (dynamic instance, value) =>
            instance.customerId = value,
        r'customerName=': (dynamic instance, value) =>
            instance.customerName = value,
        r'dropdownValue=': (dynamic instance, value) =>
            instance.dropdownValue = value,
        r'dropdownValue2=': (dynamic instance, value) =>
            instance.dropdownValue2 = value,
        r'multiSelectValues=': (dynamic instance, value) =>
            instance.multiSelectValues = value,
        r'dateTime=': (dynamic instance, value) => instance.dateTime = value,
        r'dateTime2=': (dynamic instance, value) => instance.dateTime2 = value,
        r'isChecked=': (dynamic instance, value) => instance.isChecked = value
      },
      null,
      [
        const [0, 0, null],
        const [1, 0, null],
        const [
          0,
          0,
          const [
            #receiptKey,
            #customerId,
            #customerName,
            #dropdownValue,
            #dropdownValue2,
            #multiSelectValues,
            #dateTime,
            #dateTime2,
            #isChecked
          ]
        ]
      ])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
