import 'package:eh_flutter_framework/main/common/constants/common_constant.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_double_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_common_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';

import '../main/common/services/common/eh_rest_service.dart';
import '../main/common/widgets/eh_datagrid/eh_service_datagrid_source.dart';

class DataGridTest {
  static getDataGridSource() {
    //return getStaticDataGridSource();
    return getServiceDataGridSource();
    //return getCommonDataGridSource();
  }

  // static getStaticDataGridSource() {
  //   return EHDataGridSource(
  //       // loadDataAtInit: false,
  //       columnFilters: [
  //         EHFilterInfo(columnName: 'id', sort: EHDataGridColumnSortType.Asc)
  //       ],
  //       columnsConfig: [
  //         EHColumnConf('id', EHIntColumnType()),
  //         EHColumnConf('customerId', EHIntColumnType()),
  //         EHColumnConf('name', EHStringColumnType()),
  //         EHColumnConf(
  //             'city',
  //             EHStringColumnType(widgetType: EHWidgetType.DropDown, items: {
  //               'PEK': 'Beijing',
  //               'SH': 'Shanghai',
  //               'SZ': 'Shenzhen'
  //             })),
  //         EHColumnConf('qty', EHDoubleColumnType()),
  //         EHColumnConf('date', EHDateColumnType()),
  //         EHColumnConf('isConfirmed', EHBoolColumnType(), columnWidth: 110),
  //       ],
  //       getData: (
  //         Map<String, Object?> filters,
  //         Map<String, String> orderBy,
  //         int pageIndex,
  //         int pageSize,
  //       ) async =>
  //           await DataGridTest.getOrders(
  //               filters, orderBy, pageIndex, pageSize));
  // }

  static getCommonDataGridSource() {
    return EHCommonDataGridSource(
      dataSourceCode: 'orders.list.query',
      columnFilters: [
        EHFilterInfo(columnName: 'id', sort: EHDataGridColumnSortType.Asc)
      ],
      columnsConfig: [
        EHColumnConf('id', EHIntColumnType()),
        EHColumnConf('receiptKey', EHIntColumnType()),
        EHColumnConf('name', EHStringColumnType()),
        EHColumnConf(
            'city',
            EHStringColumnType(
                widgetType: EHWidgetType.DropDown,
                items: {'PEK': 'Beijing', 'SH': 'Shanghai', 'SZ': 'Shenzhen'})),
        EHColumnConf('qty', EHDoubleColumnType()),
        EHColumnConf('date', EHDateColumnType()),
        EHColumnConf('enabled', EHBoolColumnType(), columnWidth: 110),
      ],
    );
  }

  static getServiceDataGridSource() {
    return EHServiceDataGridSource(
      serviceName: '/test-receipt',
      // loadDataAtInit: false,
      columnFilters: [
        EHFilterInfo(columnName: 'id', sort: EHDataGridColumnSortType.Asc)
      ],
      columnsConfig: [
        EHColumnConf('id', EHStringColumnType()),
        EHColumnConf('receiptKey', EHStringColumnType()),

        EHColumnConf('createTime',
            EHDateColumnType(dateFormat: CommonConstant.defaultDateTimeFormat)),
        EHColumnConf('quantity', EHDoubleColumnType()),
        EHColumnConf('enabled', EHBoolColumnType()),
        EHColumnConf(
            'city',
            EHStringColumnType(
                widgetType: EHWidgetType.DropDown,
                items: {'PEK': 'Beijing', 'SH': 'Shanghai', 'SZ': 'Shenzhen'})),

        // EHColumnConf('isConfirmed', EHBoolColumnType(), columnWidth: 110),
      ],
    );
  }

  /// Get orders collection
  static Future<List<Map<String, dynamic>>> getOrders(
    Map<String, Object?> filters,
    Map<String, String> _orderBy,
    int pageIndex,
    int pageSize,
  ) async {
    if (!EHRestService().loadingIndicator.isOpen)
      EHRestService().loadingIndicator.showIndicator();
    // final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
    //     endIndex = startIndex + 25;
    final int startIndex = 0, endIndex = 100;

    List<Map<String, dynamic>> data = [];
    for (int i = startIndex; i < endIndex; i++) {
      // orderData.add({
      //   'id': 1000 + i,
      //   'customerId': 1700 + i,
      //   'name':
      //       _names[i < _names.length ? i : _random.nextInt(_names.length - 1)],
      //   'price': _random.nextInt(1000) + _random.nextDouble(),
      //   'city': _cities[_random.nextInt(_cities.length - 1)],
      //   'qty': 1500.0 + _random.nextInt(100),
      //   'date': DateTime.now(),
      // });
      data.add({
        'id': 1000 + i,
        'receiptKey': 1700 + i,
        'name': _names[i % 15],
        'price': 1000 + i,
        'city': _cities[i % 3],
        'qty': 1500.0 + i,
        'date': DateTime.now(),
        'enabled': i % 2 == 0 ? true : false,
      });
    }

    filters.entries.forEach((element) {
      data = filterData(data, element);
    });

    // //test dynamic filtering
    // if (keyValueFilter != null) data = filterData(data, keyValueFilter);
    await Future.delayed(Duration(milliseconds: 300));
    EHRestService().loadingIndicator.hide();
    return data;
  }

  static List<Map<String, dynamic>> filterData(
      List<Map<String, dynamic>> data, MapEntry<String, Object?> filterEntry) {
    return filterEntry.value == null || filterEntry.value.toString().isEmpty
        ? data
        : data
            .where((element) => element[filterEntry.key]
                .toString()
                .contains(filterEntry.value.toString()))
            .toList();
  }

  //static math.Random _random = math.Random();

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
    'PEK',
    'SH',
    'SZ',
  ];
}
