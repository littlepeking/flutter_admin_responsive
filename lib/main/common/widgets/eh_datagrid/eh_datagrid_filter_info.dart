import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHDateGridFilterInfo {
  Rx<EHDataGridColumnSortType> sort = EHDataGridColumnSortType.None.obs;
  TextEditingController controller = TextEditingController();
  EHDateGridFilterInfo();
}
