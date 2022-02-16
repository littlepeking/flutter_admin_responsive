///Package imports
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_Image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

/// DataGrid Package
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'eh_datagrid_constants.dart';
import 'eh_datagrid_source.dart';

/// Render data pager
class EHDataGrid extends EHStatelessWidget<EHDataGridController> {
  /// Create data pager
  EHDataGrid({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    print(this.controller);
    return Container(
        height: controller.fixedHeight ?? double.infinity,
        child: _buildLayoutBuilder());
  }

  getGridColumns() {
    this.controller.dataGridSource.columnsConfig.forEach((columnConfig) =>
        controller.dataGridSource.columnFilters.putIfAbsent(
            columnConfig.columnName, () => EHDateGridFilterInfo()));

    List<GridColumn> gridColumnList = this
        .controller
        .dataGridSource
        .columnsConfig
        .map(
          (columnConfig) => GridColumn(
              minimumWidth: 100,
              width: columnConfig.width.value,
              columnName: columnConfig.columnName,
              label: columnConfig.columnType is EHImageButtonColumnType
                  ? SizedBox()
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.centerRight,
                      child: Column(children: [
                        GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  columnConfig.columnHeaderName != null
                                      ? columnConfig.columnHeaderName!.tr
                                      : columnConfig.columnName.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Obx(
                                  () => Icon(
                                    this
                                                .controller
                                                .dataGridSource
                                                .columnFilters[
                                                    columnConfig.columnName]!
                                                .sort
                                                .value ==
                                            EHDataGridColumnSortType.Desc
                                        ? Icons.arrow_downward
                                        : this
                                                    .controller
                                                    .dataGridSource
                                                    .columnFilters[columnConfig
                                                        .columnName]!
                                                    .sort
                                                    .value ==
                                                EHDataGridColumnSortType.Asc
                                            ? Icons.arrow_upward
                                            : null,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              this
                                  .controller
                                  .dataGridSource
                                  .columnFilters
                                  .entries
                                  .where(
                                      (e) => e.key != columnConfig.columnName)
                                  .forEach((e) {
                                e.value.sort.value =
                                    EHDataGridColumnSortType.None;
                              });

                              switch (this
                                  .controller
                                  .dataGridSource
                                  .columnFilters[columnConfig.columnName]!
                                  .sort
                                  .value) {
                                case EHDataGridColumnSortType.None:
                                  this
                                      .controller
                                      .dataGridSource
                                      .columnFilters[columnConfig.columnName]!
                                      .sort
                                      .value = EHDataGridColumnSortType.Asc;
                                  break;

                                case EHDataGridColumnSortType.Asc:
                                  this
                                      .controller
                                      .dataGridSource
                                      .columnFilters[columnConfig.columnName]!
                                      .sort
                                      .value = EHDataGridColumnSortType.Desc;

                                  break;
                                case EHDataGridColumnSortType.Desc:
                                  this
                                      .controller
                                      .dataGridSource
                                      .columnFilters[columnConfig.columnName]!
                                      .sort
                                      .value = EHDataGridColumnSortType.None;

                                  break;
                              }
                              this.controller.dataGridSource.handleRefresh();
                            }),
                        //   Divider(),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 25,
                            child: TextField(
                              controller: controller
                                  .dataGridSource
                                  .columnFilters[columnConfig.columnName]!
                                  .controller,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                border: new OutlineInputBorder(),
                                hintText: "Filter...".tr,
                              ),
                            )),
                      ]))),
        )
        .toList();

    return gridColumnList;
  }

  Widget _buildDataGrid() {
    // print(this.controller);
    // print(this.controller.dataPagerHeight);
    // print(this.controller.dataGridSource.pageSize!);

    return Obx(() => SfDataGrid(
        rowHeight: this.controller.rowHeight,
        headerRowHeight: this.controller.headerRowHeight,
        source: this.controller.dataGridSource,
        rowsPerPage: this.controller.dataGridSource.pageSize!.value,
        allowSorting: false,
        allowColumnsResizing: true,
        columnResizeMode: ColumnResizeMode.onResize,
        columnWidthMode: ColumnWidthMode.fill,
        columns: getGridColumns(),
        onColumnResizeUpdate: (ColumnResizeUpdateDetails args) {
          EHDataGridColumnConfig column = this
              .controller
              .dataGridSource
              .columnsConfig
              .where((element) => element.columnName == args.column.columnName)
              .single;
          column.width.value = args.width;
          return true;
        }));
  }

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
          brightness: Get.theme.colorScheme.brightness,
          selectedItemColor: Get.theme.backgroundColor),
      child: SfDataPager(
        onPageNavigationStart: (pagenumber) async {
          if (this.controller.dataGridSource.pageIndex != pagenumber) {
            this.controller.dataGridSource.pageIndex = pagenumber;
            await this.controller.dataGridSource.handleRefresh();
          }
        },
        onPageNavigationEnd: (pagenumber) => {}, //hide spinner
        delegate: controller.dataGridSource,
        availableRowsPerPage: const <int>[25, 50, 100, 200],
        pageCount: controller.dataGridSource.totalPageNumber!,
        onRowsPerPageChanged: (int? rowsPerPage) async {
          this.controller.dataGridSource.pageSize!.value = rowsPerPage!;
          await this.controller.dataGridSource.handleRefresh();
        },
        direction: Axis.horizontal,
      ),
    );
  }

  Widget _buildLayoutBuilder() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return Column(
        children: <Widget>[
          SizedBox(
              height: constraint.maxHeight - this.controller.dataPagerHeight,
              width: constraint.maxWidth,
              child: _buildDataGrid()),
          Container(
            height: controller.dataPagerHeight,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.12),
                border: Border(
                    top: BorderSide(
                        width: .5,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.12)),
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none)),
            child: Align(alignment: Alignment.center, child: _buildDataPager()),
          )
        ],
      );
    });
  }
}
