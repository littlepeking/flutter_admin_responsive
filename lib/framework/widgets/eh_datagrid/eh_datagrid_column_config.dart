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

import 'package:enhantec_platform_ui/framework/widgets/eh_datagrid/eh_column/eh_column_type.dart';
import 'package:enhantec_platform_ui/framework/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:get/get.dart';

class EHColumnConf {
  String columnName;

  String?
      fullQuanifiedName; //For matching exact DB column name to avoid multi tab;e columns name conflict. e.g.: a.receiptKey

  String? sortColumnName; //排序时使用的列，默认为columnName
  //列头显示名称
  String? columnHeaderMsgKey;
  //控件类型：用于排序比较和选择控件展示
  EHColumnType columnType;

  RxDouble width; // Double.nan.obs;

  EHGridColHideType hideType;

  EHColumnConf(
    this.columnName,
    this.columnType, {
    this.fullQuanifiedName,
    double? columnWidth,
    this.columnHeaderMsgKey,
    this.sortColumnName,
    this.hideType = EHGridColHideType.None,
  }) : width = columnWidth == null ? 150.0.obs : columnWidth.obs;
}
