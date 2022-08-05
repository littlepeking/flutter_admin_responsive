abstract class EHModel {
  String? id;
  DateTime? addDate;
  DateTime? editDate;
  String? addWho;
  String? editWho;

  // EHModel(this.addDate, this.addWho, this.editDate, this.editWho);

  toJson();

  fromJson(Map<String, dynamic> json);

  EHModel({
    this.id,
    this.addDate,
    this.editDate,
    this.addWho,
    this.editWho,
  });
}
