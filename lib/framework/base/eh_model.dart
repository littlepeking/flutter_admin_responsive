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
