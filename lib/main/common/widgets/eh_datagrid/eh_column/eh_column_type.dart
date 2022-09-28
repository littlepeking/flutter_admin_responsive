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

import 'package:eh_flutter_framework/main/common/constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:flutter/material.dart';

abstract class EHColumnType<T> {
  EHWidgetType widgetType;
  Map<String, String>? items;
  Alignment alignment;
  double padding;
  bool hasFilter;
  EHColumnType(
      {this.widgetType = EHWidgetType.Text,
      this.items = const {'': ''},
      this.padding = defaultPadding,
      this.alignment = Alignment.topLeft,
      this.hasFilter = true});

  getWidget(T value, int rowIndex, String columnName, List<Map> dataList);
}
