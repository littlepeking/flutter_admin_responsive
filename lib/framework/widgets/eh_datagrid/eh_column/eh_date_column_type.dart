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
import 'package:enhantec_platform_ui/framework/widgets/eh_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../framework/constants/common_constant.dart';

class EHDateColumnType extends EHColumnType<DateTime> {
  String dateFormat;
  EHDateColumnType({this.dateFormat = CommonConstant.defaultDateFormat});

  @override
  getWidget(DateTime? value, int rowIndex, columnName, List<Map> dataList) {
    return Container(
      padding: EdgeInsets.all(this.padding),
      alignment: alignment,
      child: EHText(
        text: value == null ? '' : DateFormat(dateFormat).format(value),
      ),
    );
  }
}
