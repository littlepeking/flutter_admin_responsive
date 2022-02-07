import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_constants.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';

import 'dart:math' as math;

class ReceiptEditController extends EHController {
  EHTabsViewController receiptHeaderTabsViewController = EHTabsViewController();

  EHDataGridController asnHeaderDataGridController =
      EHDataGridController(AsnHeaderDataGridSource());

  EHTabsViewController receiptDetailTabsViewController = EHTabsViewController();
}

class AsnHeaderDataGridSource extends EHDataGridSource {
  List<Map> allDataRows = [];

  @override
  List<EHDataGridColumnConfig> getColumnsConfig() {
    return [
      EHDataGridColumnConfig('id', EHDataGridColumnType.int),
      EHDataGridColumnConfig('customerId', EHDataGridColumnType.int),
      EHDataGridColumnConfig('name', EHDataGridColumnType.string),
      EHDataGridColumnConfig('city', EHDataGridColumnType.string),
      EHDataGridColumnConfig('qty', EHDataGridColumnType.double),
      EHDataGridColumnConfig('date', EHDataGridColumnType.datatime),
    ];
  }

  @override
  Future<List<Map>> getData() async {
    //await Future<void>.delayed(const Duration(seconds: 5));
    return getOrders(allDataRows);
  }

  /// Get orders collection
  List<Map> getOrders(List<Map> orderData) {
    final int startIndex = orderData.isNotEmpty ? orderData.length : 0,
        endIndex = startIndex + 25;
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
