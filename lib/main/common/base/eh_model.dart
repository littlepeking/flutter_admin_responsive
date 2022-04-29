abstract class EHModel {
  String? id;
  DateTime? addDate;
  DateTime? editDate;
  String? addWho;
  String? editWho;
  String? orgId;

  // EHModel(this.addDate, this.addWho, this.editDate, this.editWho);

  toJson();
}
