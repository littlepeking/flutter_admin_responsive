import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_double_column_type.dart';

import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

import 'receipt_detail_view_controller.dart';

class ReceiptEditController extends EHController {
  EHTabsViewController receiptHeaderTabsViewController = EHTabsViewController();

  late AsnHeaderDataGridSource headerSource;
  late EHDataGridController asnHeaderDataGridController;

  ReceiptEditController() {
    AsnHeaderDataGridSource asnHeaderDataGridSource = AsnHeaderDataGridSource();
    asnHeaderDataGridSource.columnFilters['id'] = EHDateGridFilterInfo();
    asnHeaderDataGridSource.columnFilters['id']!.sort.value =
        EHDataGridColumnSortType.Asc;
    asnHeaderDataGridController = EHDataGridController(asnHeaderDataGridSource,
        fixedHeight: Responsive.isMobile(Get.context!) ? 500 : double.infinity);
  }

  EHDataGridController asnDetailDataGridController = EHDataGridController(
      AsnHeaderDataGridSource(),
      fixedHeight: Responsive.isMobile(Get.context!) ? 500 : double.infinity);

  EHTabsViewController receiptDetailTabsViewController = EHTabsViewController();

  ReceiptDetailViewController receiptDetailInfoController =
      ReceiptDetailViewController();
}

class AsnHeaderDataGridSource extends EHDataGridSource {
  List<Map> allDataRows = [];

  List<EHDataGridColumnConfig> columnConfig = [
    EHDataGridColumnConfig(columnName: 'id', columnType: EHIntColumnType()),
    EHDataGridColumnConfig(
        columnName: 'customerId', columnType: EHIntColumnType()),
    EHDataGridColumnConfig(
        columnName: 'name', columnType: EHStringColumnType()),
    EHDataGridColumnConfig(
        columnName: 'city', columnType: EHStringColumnType()),
    EHDataGridColumnConfig(columnName: 'qty', columnType: EHDoubleColumnType()),
    EHDataGridColumnConfig(columnName: 'date', columnType: EHDateColumnType()),
  ];

  @override
  List<EHDataGridColumnConfig> getColumnsConfig() {
    return columnConfig;
  }

  @override
  Future<List<Map>> getData() async {
    //await Future<void>.delayed(const Duration(seconds: 5));
    return getOrders(allDataRows);
  }

  /// Get orders collection
  List<Map> getOrders(List<Map> orderData) {
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

  final math.Random _random = math.Random();

  //  Order Data's
  final List<String> _names = <String>[
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

  final List<String> _cities = <String>[
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
