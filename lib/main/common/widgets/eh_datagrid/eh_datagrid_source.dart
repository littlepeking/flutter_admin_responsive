// ignore_for_file: non_constant_identifier_names
/// Dart import
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_Image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_double_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_string_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';

/// Package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'eh_datagrid_constants.dart';

/// Set order's data collection to data grid source.
class EHDataGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  EHDataGridSource(
      {this.isMobile = false,
      this.pageIndex = -1,
      List<EHDataGridFilterInfo>? columnFilters,
      required this.columnsConfig,
      required this.getData}) {
    this.columnFilters = columnFilters != null
        ? columnFilters.obs
        : <EHDataGridFilterInfo>[].obs;
  }

  var selectable;

  late Future<List<Map>> Function(
    Map<String, String> filters,
    Map<String, String> orderBy,
    int pageIndex,
    int pageSize,
  ) getData;

  /// Determine to decide whether the platform is mobile or web/tablet.
  bool isMobile = false;

  List<EHDataGridColumnConfig> columnsConfig;

  List<Map> _dataList = <Map>[];

  RxInt? pageSize = 25.obs;

  int? pageIndex = -1;

  double? totalPageNumber = 1;

  //Key: column name, value: filter value controller
  late RxList<EHDataGridFilterInfo> columnFilters =
      <EHDataGridFilterInfo>[].obs;

  /// Instance of DataGridRow.
  List<DataGridRow> _dataGridRows = <DataGridRow>[];

  Map<String, String> get filters {
    Map<String, String> _filters = Map();

    columnFilters.forEach((element) {
      _filters.putIfAbsent(element.columnName, () => element.text);
    });

    return _filters;
  }

  Map<String, String> get orderBy {
    Map<String, String> _orderBy = Map();

    columnFilters.forEach((element) {
      EHDataGridColumnSortType orderByVal = element.sort;
      if (orderByVal != EHDataGridColumnSortType.None)
        _orderBy.putIfAbsent(
            element.columnName,
            () => orderByVal
                .toString()
                .substring(orderByVal.toString().indexOf('.') + 1));
    });

    return _orderBy;
  }

  /// Building DataGridRows
  void buildDataGridRows() {
    List<DataGridRow> rows = _dataList.map<DataGridRow>((Map row) {
      if (isMobile) {
        columnsConfig =
            columnsConfig.where((element) => !element.hideInMobile).toList();
      }

      List<DataGridCell<Object>> cellList = columnsConfig.map((columnConfig) {
        if (!row.containsKey(columnConfig.columnName))
          return DataGridCell<String>(
              columnName: columnConfig.columnName, value: '');
        // throw Exception("当前DataGrid的数据行未包含已配置的列${columnConfig.columnName}");

        if (columnConfig.columnType is EHIntColumnType) {
          return DataGridCell<int>(
              columnName: columnConfig.columnName,
              value: row[columnConfig.columnName]);
        }
        if (columnConfig.columnType is EHDoubleColumnType) {
          return DataGridCell<double>(
              columnName: columnConfig.columnName,
              value: row[columnConfig.columnName]);
        }
        if (columnConfig.columnType is EHDateColumnType) {
          return DataGridCell<DateTime>(
              columnName: columnConfig.columnName,
              value: row[columnConfig.columnName]);
        }
        if (columnConfig.columnType is EHStringColumnType) {
          return DataGridCell<String>(
              columnName: columnConfig.columnName,
              value: row[columnConfig.columnName]);
        }
        if (columnConfig.columnType is EHBoolColumnType) {
          return DataGridCell<bool>(
              columnName: columnConfig.columnName,
              value: row[columnConfig.columnName]);
        }

        throw Exception(
            "DataGrid中列${columnConfig.columnName}配置的ColumnType ${columnConfig.columnType} 不存在");
      }).toList();

      return DataGridRow(cells: cellList);
    }).toList();

    this._dataGridRows = rows;
  }

  // Overrides

  @override
  List<DataGridRow> get rows => _dataGridRows;

  List<Map> get dataList {
    return _dataList;
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = _dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if ((rowIndex % 2) == 0) {
      backgroundColor = Colors.grey.withOpacity(0.07);
    }

    List<Widget> cellWidgets = [];
    columnsConfig.forEach((config) {
      Iterable<DataGridCell> iterableDateGridCell =
          row.getCells().where((cell) => cell.columnName == config.columnName);
      Object currentCellValue;
      if (config.columnType is EHImageButtonColumnType) {
        currentCellValue = _dataList[rowIndex];
      } else if (iterableDateGridCell.length == 1) {
        currentCellValue = iterableDateGridCell.first.value;
      } else {
        currentCellValue = '';
      }

      cellWidgets.add(config.columnType
          .getWidget(currentCellValue, rowIndex, config.columnName, _dataList));
    });

    return DataGridRowAdapter(color: backgroundColor, cells: cellWidgets);
  }

  // @override
  // Future<void> handleLoadMoreRows() async {
  //   await Future<void>.delayed(const Duration(seconds: 5));

  //   //TO DO:// INCREASE PAGE IF HAS
  //   dataList = getData();
  //   buildDataGridRows();
  //   notifyListeners();
  // }

  @override
  Future<void> handleRefresh() async {
    try {
      await requestData();
      buildDataGridRows();
      notifyListeners();
    } catch (e) {
      EHToastMessageHelper.showInfoMessage("Data update failed");
    }
  }

  Future<List<Map>> requestData() async {
    try {
      _dataList = await getData(this.filters, this.orderBy, this.pageIndex ?? 0,
          this.pageSize!.value);
      return _dataList;
    } catch (e) {
      EHToastMessageHelper.showInfoMessage(
          "Data request failed from server" + e.toString());
    }
    return <Map>[];
  }

  // @override
  // Widget? buildTableSummaryCellWidget(
  //     GridTableSummaryRow summaryRow,
  //     GridSummaryColumn? summaryColumn,
  //     RowColumnIndex rowColumnIndex,
  //     String summaryValue) {
  //   Widget buildCell(String value, EdgeInsets padding, Alignment alignment) {
  //     return Container(
  //       padding: padding,
  //       alignment: alignment,
  //       child: Text(value,
  //           overflow: TextOverflow.ellipsis,
  //           style: const TextStyle(fontWeight: FontWeight.w500)),
  //     );
  //   }

  //   if (summaryRow.showSummaryInRow) {
  //     return buildCell(
  //         summaryValue, const EdgeInsets.all(16.0), Alignment.centerLeft);
  //   } else if (summaryValue.isNotEmpty) {
  //     if (summaryColumn!.columnName == 'freight') {
  //       summaryValue = double.parse(summaryValue).toStringAsFixed(2);
  //     }

  //     summaryValue = 'Sum: ' +
  //         NumberFormat.currency(locale: 'en_US', decimalDigits: 0, symbol: r'$')
  //             .format(double.parse(summaryValue));

  //     return buildCell(
  //         summaryValue, const EdgeInsets.all(8.0), Alignment.centerRight);
  //   }
  // }

  /// Update DataSource
  void updateDataSource() {
    notifyListeners();
  }
}
