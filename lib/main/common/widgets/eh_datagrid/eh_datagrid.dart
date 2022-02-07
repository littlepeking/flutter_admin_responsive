///Package imports
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

/// DataGrid Package
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

/// Render data pager
class EHDataGrid<T extends EHDataGridController> extends EHStatelessWidget<T> {
  /// Create data pager
  EHDataGrid({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    print(this.controller);
    return _buildLayoutBuilder();
  }

  getGridColumns() {
    List<GridColumn> gridColumnList = this
        .controller
        .dataGridSource
        .getColumnsConfig()
        .map(
          (columnConfig) => GridColumn(
              minimumWidth: 120,
              width: double.nan,
              columnName: columnConfig.columnName,
              label: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: Column(children: [
                    Container(
                      height: 30,
                      child: TextField(
                        controller: controller.dataGridSource
                            .columnFilterMap[columnConfig.columnName],
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          border: new OutlineInputBorder(),
                          hintText: "Filter...".tr,
                        ),
                      ),
                    ),
                    Divider(),
                    Text(
                      columnConfig.columnHeaderName != null
                          ? columnConfig.columnHeaderName!.tr
                          : columnConfig.columnName.tr,
                      overflow: TextOverflow.ellipsis,
                    )
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
        headerRowHeight: this.controller.dataPagerHeight,
        source: this.controller.dataGridSource,
        rowsPerPage: this.controller.dataGridSource.pageSize!.value,
        allowSorting: false,
        allowColumnsResizing: true,
        columnWidthMode: ColumnWidthMode.fill,
        columns: getGridColumns()));
  }

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Get.theme.colorScheme.brightness,
        selectedItemColor: Get.theme.backgroundColor,
      ),
      child: SfDataPager(
        onPageNavigationStart: (pagenumber) async {
          if (this.controller.dataGridSource.pageIndex != pagenumber) {
            this.controller.dataGridSource.pageIndex = pagenumber;
            await this.controller.dataGridSource.refresh();
          }
        },
        onPageNavigationEnd: (pagenumber) => {}, //hide spinner
        delegate: controller.dataGridSource,
        availableRowsPerPage: const <int>[25, 50, 100, 200],
        pageCount: controller.dataGridSource.totalPageNumber!,
        onRowsPerPageChanged: (int? rowsPerPage) async {
          this.controller.dataGridSource.pageSize!.value = rowsPerPage!;
          await this.controller.dataGridSource.refresh();
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
