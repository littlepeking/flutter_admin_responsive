import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_Image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_double_column_type.dart';

import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tab.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'receipt_detail_view.dart';
import 'receipt_detail_view_controller.dart';

class ReceiptEditController extends EHController {
  PageStorageBucket pageStorageBucket = PageStorageBucket();

  late EHTabsViewController receiptHeaderTabsViewController;

  late EHTabsViewController receiptDetailTabsViewController;

  EHDataGridController asnHeaderDataGridController = EHDataGridController();

  ReceiptDetailViewController receiptDetailInfoController =
      ReceiptDetailViewController();

  ReceiptEditController() {
    initGrid(asnHeaderDataGridController);

    receiptHeaderTabsViewController = EHTabsViewController(tabs: [
      EHTab('General Info', asnHeaderDataGridController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: EHDataGrid(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);

    receiptDetailTabsViewController = EHTabsViewController(tabs: [
      EHTab('Detail Info', receiptDetailInfoController, (EHController c) {
        return PageStorage(
            bucket: pageStorageBucket,
            child: ReceiptDetailView(
              controller: c,
            ));
      }),
      // EHTab('Summary Info', controller, (controller) => Center()),
      // EHTab('Other', controller, (controller) => EditingDataGrid()),
    ]);
  }

  // EHDataGridController asnDetailDataGridController = EHDataGridController(
  //     AsnHeaderDataGridSource(),
  //     fixedHeight: Responsive.isMobile(Get.context!) ? 500 : double.infinity);

  initGrid(EHDataGridController gridController) {
    gridController.dataGridSource.columnFilters['id'] = EHDateGridFilterInfo();
    gridController.dataGridSource.columnFilters['id']!.sort.value =
        EHDataGridColumnSortType.Asc;

    gridController.dataGridSource.columnsConfig = [
      EHDataGridColumnConfig(
          columnName: 'imageBtn',
          columnType: EHImageButtonColumnType(
              //  onPressed: (data) => Get.defaultDialog(title: data.toString()))),
              onPressed: (data) => Get.defaultDialog(
                    content: Container(
                        height: 500,
                        width: 500,
                        child: EHTabsView(
                            expandMode: ExpandMode.Flexible,
                            controller: receiptHeaderTabsViewController)),
                  ))),
      EHDataGridColumnConfig(columnName: 'id', columnType: EHIntColumnType()),
      EHDataGridColumnConfig(
          columnName: 'customerId', columnType: EHIntColumnType()),
      EHDataGridColumnConfig(
          columnName: 'name', columnType: EHStringColumnType()),
      EHDataGridColumnConfig(
          columnName: 'city', columnType: EHStringColumnType()),
      EHDataGridColumnConfig(
          columnName: 'qty', columnType: EHDoubleColumnType()),
      EHDataGridColumnConfig(
          columnName: 'date', columnType: EHDateColumnType()),
    ];

    gridController.dataGridSource.getData = (
      Map<String, String> filters,
      Map<String, String> _orderBy,
      int pageIndex,
      int pageSize,
    ) =>
        TestData.getOrders([]);
  }
}

class TestData extends EHDataGridSource {
  /// Get orders collection
  static List<Map> getOrders(List<Map> orderData) {
    // final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
    //     endIndex = startIndex + 25;
    final int startIndex = 0, endIndex = 100;
    for (int i = startIndex; i < endIndex; i++) {
      orderData.add({
        'id': 1000 + i,
        'customerId': 1700 + i,
        'name':
            _names[i < _names.length ? i : _random.nextInt(_names.length - 1)],
        'price': _random.nextInt(1000) + _random.nextDouble(),
        'city': _cities[_random.nextInt(_cities.length - 1)],
        'qty': 1500.0 + _random.nextInt(100),
        'date': DateTime.now(),
      });
    }
    return orderData;
  }

  static math.Random _random = math.Random();

  //  Order Data's
  static List<String> _names = <String>[
    'Welli',
    'Blonp',
    'Folko',
    'Furip',
    'Folig',
    'Picco',
    'Frans',
    'Warth',
    'Linod',
    'Simop',
    'Merep',
    'Riscu',
    'Seves',
    'Vaffe',
    'Alfki',
  ];

  static List<String> _cities = <String>[
    'Bruxelles',
    'Rosario',
    'Recife',
    'Graz',
    'Montreal',
    'Tsawassen',
    'Campinas',
    'Resende',
  ];
}
