/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:json_annotation/json_annotation.dart';

class _EHDateTime2TimeStampConverter implements JsonConverter<DateTime?, int?> {
  const _EHDateTime2TimeStampConverter();

  @override
  DateTime? fromJson(int? json) =>
      json == null ? null : DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int? toJson(DateTime? object) =>
      object == null ? null : object.millisecondsSinceEpoch;
}

const EHDateTime2TimeStampConverter = _EHDateTime2TimeStampConverter();

class _EHList2StringConverter implements JsonConverter<List<String>, String?> {
  const _EHList2StringConverter();

  @override
  List<String> fromJson(String? json) =>
      json == null || json.trim() == '' ? [] : json.split(',');

  @override
  String? toJson(List<String> list) => list.join(',');
}

const EHList2StringConverter = _EHList2StringConverter();
