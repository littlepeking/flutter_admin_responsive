///Package imports
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_Image_button_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

/// DataGrid Package
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../EH_multi_select.dart';
import 'eh_datagrid_constants.dart';

/// Render data pager
class EHDataGrid extends EHStatelessWidget<EHDataGridController> {
  /// Create data pager
  EHDataGrid({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: controller.fixedHeight ?? double.infinity,
        child: _buildLayoutBuilder());
  }

  List<GridColumn> getGridColumns() {
    this.controller.dataGridSource.columnsConfig.forEach((columnConfig) {
      if (controller.dataGridSource.columnFilters
          .where((element) => element.columnName == columnConfig.columnName)
          .isEmpty) {
        controller.dataGridSource.columnFilters
            .add(EHDataGridFilterInfo(columnName: columnConfig.columnName));
      }
    });

    List<GridColumn> gridColumnList =
        this.controller.dataGridSource.columnsConfig.map(
      (columnConfig) {
        return GridColumn(
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
                                  style: new TextStyle().copyWith(
                                      fontSize: Theme.of(Get.context!)
                                          .textTheme
                                          .bodyText1!
                                          .fontSize,
                                      fontWeight: FontWeight.bold)),
                              Obx(
                                () => Icon(
                                  getColumnFilter(columnConfig.columnName)
                                              .sort ==
                                          EHDataGridColumnSortType.Desc
                                      ? Icons.arrow_downward
                                      : getColumnFilter(columnConfig.columnName)
                                                  .sort ==
                                              EHDataGridColumnSortType.Asc
                                          ? Icons.arrow_upward
                                          : null,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                          onTap: () => sortColumn(columnConfig)),
                      //   Divider(),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          height: 25, child: buildFilterWidget(columnConfig)),
                    ])));
      },
    ).toList();

    return gridColumnList;
  }

  buildFilterWidget(EHDataGridColumnConfig columnConfig) {
    if (columnConfig.columnType is EHBoolColumnType) {
      return Obx(() => EHDropdown(
          controller: EHDropDownController(
              key: GlobalKey(),
              dropDownWidth: 100,
              padding: EdgeInsets.zero,
              showErrorInfo: false,
              showLabel: false,
              bindingValue: getColumnFilter(columnConfig.columnName).text,
              focusNode:
                  controller.dataGridSource.getFilterFocusNode(columnConfig),
              items: {
                '': '------',
                'true': 'Yes'.tr,
                'false': 'No'.tr,
              },
              onChanged: (value) {
                getColumnFilter(columnConfig.columnName).text = value;
                controller.dataGridSource.columnFilters.refresh();
                filterGridData(controller, columnConfig);
              })));
    }

    if (columnConfig.columnType.widgetType == EHWidgetType.Text) {
      return TextField(
          focusNode: controller.dataGridSource.getFilterFocusNode(columnConfig),
          controller: EHTextEditingController(
              text: getColumnFilter(columnConfig.columnName).text),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            border: new OutlineInputBorder(),
            hintText: "Filter...".tr,
          ),
          onChanged: (value) {
            getColumnFilter(columnConfig.columnName).text = value;
          },
          onSubmitted: (value) async {
            filterGridData(controller, columnConfig);
          });
    } else if (columnConfig.columnType.widgetType == EHWidgetType.DropDown) {
      return Obx(() => EHMultiSelect(
            controller: EHMultiSelectController(
              key: GlobalKey(),
              allowSelectEmpty: true,
              padding: EdgeInsets.zero,
              showErrorInfo: false,
              showLabel: false,
              focusNode: FocusNode(),
              bindingValue: EHUtilHelper.isEmpty(
                      getColumnFilter(columnConfig.columnName).text)
                  ? []
                  : getColumnFilter(columnConfig.columnName).text.split(','),
              items: columnConfig.columnType.items!,
              onChanged: (value) {
                getColumnFilter(columnConfig.columnName).text = value.join(',');
                controller.dataGridSource.columnFilters.refresh();
                filterGridData(controller, columnConfig);
              },
            ),
          ));
    }
  }

  filterGridData(EHDataGridController controller,
      EHDataGridColumnConfig columnConfig) async {
    await controller.dataGridSource.handleRefresh();

    controller.dataGridSource.getFilterFocusNode(columnConfig).requestFocus();
  }

  int getColumnIndex(EHDataGridColumnConfig columnConfig) {
    return controller.dataGridSource.columnsConfig
        .where((c) => !c.columnName.contains('__'))
        .toList()
        .indexOf(columnConfig);
  }

  EHDataGridFilterInfo getColumnFilter(String columnName) {
    return controller.dataGridSource.columnFilters
        .where((e) => e.columnName == columnName)
        .first;
  }

  Widget _buildDataGrid() {
    // print(this.controller);
    // print(this.controller.dataPagerHeight);
    // print(this.controller.dataGridSource.pageSize!);

    return
        //Obx(() =>

        SfDataGrid(
            showCheckboxColumn: controller.showCheckbox,
            selectionMode: SelectionMode.multiple,
            //navigationMode: GridNavigationMode.row,
            controller: controller.dataGridSource.dataGridController,
            rowHeight: this.controller.rowHeight,
            headerRowHeight: this.controller.headerRowHeight,
            source: this.controller.dataGridSource,
            //rowsPerPage: this.controller.dataGridSource.pageSize!.value,
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
                  .where(
                      (element) => element.columnName == args.column.columnName)
                  .single;
              column.width.value = args.width;
              return true;
            }
            //)
            );
  }

  Widget _buildDataPager() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Get.theme.colorScheme.brightness,
        selectedItemColor: Colors.grey,
        itemBorderWidth: 0,
        itemBorderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: SfDataPager(
        itemWidth: 40,
        itemHeight: 40,
        itemPadding: EdgeInsets.all(5),
        navigationItemHeight: 40,
        onPageNavigationStart: (pagenumber) async {
          if (this.controller.dataGridSource.pageIndex != pagenumber) {
            this.controller.dataGridSource.pageIndex = pagenumber;
            if (!controller.dataGridSource.loadDataAtInit) {
              controller.dataGridSource.loadDataAtInit = true;
              return;
            }
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

  sortColumn(EHDataGridColumnConfig columnConfig) {
    this
        .controller
        .dataGridSource
        .columnFilters
        .where((e) => e.columnName != columnConfig.columnName)
        .forEach((e) {
      e.sort = EHDataGridColumnSortType.None;
    });

    switch (getColumnFilter(columnConfig.columnName).sort) {
      case EHDataGridColumnSortType.None:
        getColumnFilter(columnConfig.columnName).sort =
            EHDataGridColumnSortType.Asc;
        break;

      case EHDataGridColumnSortType.Asc:
        this
            .controller
            .dataGridSource
            .columnFilters
            .where((e) => e.columnName == columnConfig.columnName)
            .first
            .sort = EHDataGridColumnSortType.Desc;

        break;
      case EHDataGridColumnSortType.Desc:
        getColumnFilter(columnConfig.columnName).sort =
            EHDataGridColumnSortType.None;

        break;
    }
    this.controller.dataGridSource.columnFilters.refresh();
    this.controller.dataGridSource.handleRefresh();
  }
}
