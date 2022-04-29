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
