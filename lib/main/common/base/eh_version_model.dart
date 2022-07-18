import 'package:eh_flutter_framework/main/common/base/eh_model.dart';

abstract class EHVersionModel extends EHModel {
  int? version;

  toJson();

  EHVersionModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      this.version = 1})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho);
}
