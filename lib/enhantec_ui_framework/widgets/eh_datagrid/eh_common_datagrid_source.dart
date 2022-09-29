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

import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'eh_service_datagrid_source.dart';

class EHCommonDataGridSource extends EHServiceDataGridSource {
  String dataSourceCode;

  EHCommonDataGridSource(
      {required this.dataSourceCode,
      required List<EHColumnConf> columnsConfig,
      List<EHFilterInfo> columnFilters = const [],
      int? pageIndex,
      bool loadDataAtInit = true})
      : super(
            pageIndex: pageIndex,
            columnFilters: columnFilters,
            columnsConfig: columnsConfig,
            loadDataAtInit: loadDataAtInit,
            params: {'dataSourceCode': dataSourceCode});
}
