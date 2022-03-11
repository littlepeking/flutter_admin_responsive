import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_double_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_source.dart';

class DataGridTest {
  static getDataGridSource() {
    return EHDataGridSource(
        // loadDataAtInit: false,
        columnFilters: [
          EHDataGridFilterInfo(
              columnName: 'id', sort: EHDataGridColumnSortType.Asc)
        ],
        columnsConfig: [
          EHDataGridColumnConfig(
              columnName: 'id', columnType: EHIntColumnType()),
          EHDataGridColumnConfig(
              columnName: 'customerId', columnType: EHIntColumnType()),
          EHDataGridColumnConfig(
              columnName: 'name', columnType: EHStringColumnType()),
          EHDataGridColumnConfig(
              columnName: 'city',
              columnType: EHStringColumnType(
                  widgetType: EHWidgetType.DropDown,
                  selectItems: {
                    'PEK': 'Beijing',
                    'SH': 'Shanghai',
                    'SZ': 'Shenzhen'
                  })),
          EHDataGridColumnConfig(
              columnName: 'qty', columnType: EHDoubleColumnType()),
          EHDataGridColumnConfig(
              columnName: 'date', columnType: EHDateColumnType()),
          EHDataGridColumnConfig(
              columnName: 'isConfirmed',
              columnType: EHBoolColumnType(),
              columnWidth: 110),
        ],
        getData: (
          Map<String, Object?> filters,
          Map<String, String> orderBy,
          int pageIndex,
          int pageSize,
        ) async =>
            await DataGridTest.getOrders(
                filters, orderBy, pageIndex, pageSize));
  }

  /// Get orders collection
  static Future<List<Map>> getOrders(
    Map<String, Object?> filters,
    Map<String, String> _orderBy,
    int pageIndex,
    int pageSize,
  ) async {
    // final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
    //     endIndex = startIndex + 25;
    final int startIndex = 0, endIndex = 100;

    List<Map> data = [];
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
        'customerId': 1700 + i,
        'name': _names[i % 15],
        'price': 1000 + i,
        'city': _cities[i % 3],
        'qty': 1500.0 + i,
        'date': DateTime.now(),
        'isConfirmed': i % 2 == 0 ? true : false,
      });
    }

    filters.entries.forEach((element) {
      data = filterData(data, element);
    });

    // //test dynamic filtering
    // if (keyValueFilter != null) data = filterData(data, keyValueFilter);

    return data;
  }

  static List<Map> filterData(
      List<Map> data, MapEntry<String, Object?> filterEntry) {
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
