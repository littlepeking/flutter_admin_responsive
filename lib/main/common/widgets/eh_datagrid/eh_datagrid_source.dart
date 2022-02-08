// ignore_for_file: non_constant_identifier_names
/// Dart import
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';

/// Package imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../eh_text.dart';
import 'eh_datagrid_constants.dart';

import 'package:intl/intl.dart';

/// Set order's data collection to data grid source.
abstract class EHDataGridSource extends DataGridSource {
  /// Creates the order data source class with required details.
  EHDataGridSource({this.isMobile = false, this.pageIndex = -1});

  /// Determine to decide whether the platform is mobile or web/tablet.
  bool isMobile = false;

  RxInt? pageSize = 25.obs;

  int? pageIndex = -1;

  double? totalPageNumber = 1;

  //Key: column name, value: filter value controller
  Map<String, EHDateGridFilterInfo> columnFilters = Map();

  /// Instance of an order.
  List<Map> dataList = <Map>[];

  /// Instance of DataGridRow.
  List<DataGridRow> dataGridRows = <DataGridRow>[];

  Future<List<Map>> getData();

  Map<String, String> get filters {
    Map<String, String> _filters = Map();

    columnFilters.entries.forEach((element) {
      _filters.putIfAbsent(element.key, () => element.value.controller.text);
    });

    return _filters;
  }

  Map<String, String> get orderBy {
    Map<String, String> _orderBy = Map();

    columnFilters.entries.forEach((element) {
      EHDataGridColumnSortType orderByVal = element.value.sort.value;
      if (orderByVal != EHDataGridColumnSortType.None)
        _orderBy.putIfAbsent(
            element.key,
            () => orderByVal
                .toString()
                .substring(orderByVal.toString().indexOf('.') + 1));
    });

    return _orderBy;
  }

  List<EHDataGridColumnConfig> getColumnsConfig();

  /// Building DataGridRows
  void buildDataGridRows() {
    List<DataGridRow> rows = dataList.map<DataGridRow>((Map row) {
      List<EHDataGridColumnConfig> columnsConfig = getColumnsConfig();

      if (isMobile) {
        columnsConfig =
            columnsConfig.where((element) => !element.hideInMobile).toList();
      }

      List<DataGridCell<Object>> cellList = columnsConfig.map((columnConfig) {
        if (!row.containsKey(columnConfig.columnName))
          return DataGridCell<String>(
              columnName: columnConfig.columnName, value: '');
        // throw Exception("当前DataGrid的数据行未包含已配置的列${columnConfig.columnName}");

        switch (columnConfig.columnType) {
          case EHDataGridColumnType.int:
            {
              return DataGridCell<int>(
                  columnName: columnConfig.columnName,
                  value: row[columnConfig.columnName]);
            }
          case EHDataGridColumnType.double:
            {
              return DataGridCell<double>(
                  columnName: columnConfig.columnName,
                  value: row[columnConfig.columnName]);
            }
          case EHDataGridColumnType.Date:
          case EHDataGridColumnType.DateTime:
            {
              return DataGridCell<DateTime>(
                  columnName: columnConfig.columnName,
                  value: row[columnConfig.columnName]);
            }
          case EHDataGridColumnType.String:
            {
              return DataGridCell<String>(
                  columnName: columnConfig.columnName,
                  value: row[columnConfig.columnName]);
            }
          case EHDataGridColumnType.Bool:
            {
              return DataGridCell<bool>(
                  columnName: columnConfig.columnName,
                  value: row[columnConfig.columnName]);
            }
          default:
            {
              return DataGridCell<String>(
                  columnName: columnConfig.columnName,
                  value: row[columnConfig.columnName]);
            }
        }
      }).toList();

      return DataGridRow(cells: cellList);
    }).toList();

    this.dataGridRows = rows;
  }

  // Overrides

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = dataGridRows.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if ((rowIndex % 2) == 0) {
      backgroundColor = Colors.grey.withOpacity(0.07);
    }

    Widget buildWidget({
      AlignmentGeometry alignment = Alignment.centerLeft,
      EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
      TextOverflow textOverflow = TextOverflow.ellipsis,
      required Object value,
    }) {
      return Container(
        padding: padding,
        alignment: alignment,
        child: EHText(
          text: value is DateTime
              ? DateFormat('yyyy/MM/dd').format(value)
              : value.toString(),
        ),
      );

      // Container(
      //   padding: const EdgeInsets.all(8),
      //   alignment: Alignment.centerRight,
      //   child: Text(NumberFormat.currency(
      //           locale: 'en_US', symbol: r'$', decimalDigits: 0)
      //       .format(row.getCells()[5].value)),
      // ),
    }

    return DataGridRowAdapter(
        color: backgroundColor,
        cells: row.getCells().map<Widget>((DataGridCell dataCell) {
          EHDataGridColumnConfig columnConfig = getColumnsConfig()
              .where((e) => e.columnName == dataCell.columnName)
              .single;

          if (columnConfig.columnType == EHDataGridColumnType.int ||
              columnConfig.columnType == EHDataGridColumnType.double) {
            return buildWidget(
                alignment: Alignment.centerRight, value: dataCell.value!);
          } else {
            return buildWidget(value: dataCell.value!);
          }
        }).toList(growable: false));
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
    dataList = await getData();
    buildDataGridRows();
    notifyListeners();
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
