import 'package:eh_flutter_framework/main/common/base/eh_model.dart';

abstract class EHOrgModel extends EHModel {
  String? orgId;

  // EHModel(this.addDate, this.addWho, this.editDate, this.editWho);

  toJson();

  EHOrgModel(
      {String? id,
      DateTime? addDate,
      DateTime? editDate,
      String? addWho,
      String? editWho,
      this.orgId})
      : super(
            id: id,
            addDate: addDate,
            editDate: editDate,
            addWho: addWho,
            editWho: editWho);
}
