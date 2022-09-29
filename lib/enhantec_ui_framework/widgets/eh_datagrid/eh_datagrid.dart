/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

///Package imports
import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_stateless_widget.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_bool_column_type.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_date_column_type.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_double_column_type.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_column/eh_int_column_type.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_column_config.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_datagrid/eh_datagrid_filter_info.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_date_picker.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_dropdown.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Core theme import
import 'package:syncfusion_flutter_core/theme.dart';

/// DataGrid Package
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../enhantec_ui_framework/base/eh_exception.dart';
import '../../../../enhantec_ui_framework/constants/common_constant.dart';
import '../eh_multi_select.dart';
import 'eh_datagrid_constants.dart';

import 'package:intl/intl.dart';

/// Render data pager
class EHDataGrid extends EHStatelessWidget<EHDataGridController> {
  /// Create data pager
  EHDataGrid({Key? key, controller}) : super(key: key, controller: controller);
  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(Get.context!) && !controller.disableFixedHeight
        ? Container(
            height: controller.fixedHeight ?? double.infinity,
            child: _buildLayoutBuilder())
        : controller.wrapWithExpanded
            ? Expanded(child: _buildLayoutBuilder())
            : _buildLayoutBuilder();
  }

  List<GridColumn> getGridColumns() {
    this
        .controller
        .dataGridSource
        .getUnhiddenColumnConfs()
        .forEach((columnConfig) {
      if (controller.dataGridSource.columnFilters
          .where((element) => element.columnName == columnConfig.columnName)
          .isEmpty) {
        controller.dataGridSource.columnFilters
            .add(EHFilterInfo(columnName: columnConfig.columnName));
      }
    });

    List<GridColumn> gridColumnList =
        this.controller.dataGridSource.getUnhiddenColumnConfs().map(
      (columnConfig) {
        return GridColumn(
            minimumWidth: 100,
            width: columnConfig.width.value,
            columnName: columnConfig.columnName,
            label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerRight,
                child: Column(children: [
                  GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              columnConfig.columnHeaderMsgKey != null
                                  ? columnConfig.columnHeaderMsgKey!.tr
                                  : columnConfig.columnName.tr,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle().copyWith(
                                  fontSize: Theme.of(Get.context!)
                                      .textTheme
                                      .bodyLarge!
                                      .fontSize,
                                  fontWeight: FontWeight.bold)),
                          if (columnConfig.columnType.hasFilter)
                            Obx(
                              () => Icon(
                                getColumnFilter(columnConfig.columnName).sort ==
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
                      onTap: () {
                        if (columnConfig.columnType.hasFilter)
                          sortColumn(columnConfig);
                      }),
                  //   Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  columnConfig.columnType.hasFilter
                      ? Container(
                          height: 25, child: buildFilterWidget(columnConfig))
                      : SizedBox(
                          height: 25,
                        ),
                ])));
      },
    ).toList();

    return gridColumnList;
  }

  buildFilterWidget(EHColumnConf columnConfig) {
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
                '': 'common.general.all'.tr,
                'true': 'common.general.yes'.tr,
                'false': 'common.general.no'.tr,
              },
              onChanged: (value) {
                getColumnFilter(columnConfig.columnName).text = value;
                controller.dataGridSource.columnFilters.refresh();
                filterGridData(controller, columnConfig);
              })));
    } else if (columnConfig.columnType is EHDateColumnType) {
      String dateStr = getColumnFilter(columnConfig.columnName).text;

      DateTime? bindValue;

      String _dateFormat = CommonConstant.defaultDateFormat;
      // (columnConfig.columnType as EHDateColumnType).dateFormat;

      if (!EHUtilHelper.isEmpty(dateStr)) {
        try {
          // bindValue = new DateFormat(_dateFormat).parseStrict(dateStr);
          bindValue = new DateFormat(_dateFormat).parse(dateStr);
        } catch (e) {
          throw EHException('common.general.dateFormatInfo'.tr + _dateFormat);
        }
      }

      return Obx(() => EHDatePicker(
              controller: EHDatePickerController(
            key: controller.dataGridSource.getFilterKey(columnConfig),
            showErrorInfo: false,
            showLabel: false,
            setToStartTime: true,
            bindingValue: bindValue,
            focusNode:
                controller.dataGridSource.getFilterFocusNode(columnConfig),
            goNextAfterComplete: false,
            onEditingComplete: (value) {
              getColumnFilter(columnConfig.columnName).text =
                  !EHUtilHelper.isEmpty(value)
                      ? DateFormat(_dateFormat).format(value!)
                      : '';
              controller.dataGridSource.columnFilters.refresh();
              filterGridData(controller, columnConfig);
            },
          )));
    }

    if (columnConfig.columnType.widgetType == EHWidgetType.Text) {
      List<TextInputFormatter> inputFormatters = [];
      TextInputType keyboardType = TextInputType.text;
      if (columnConfig.columnType is EHIntColumnType) {
        inputFormatters =
            inputFormatters = [FilteringTextInputFormatter.digitsOnly];

        keyboardType = TextInputType.number;
      } else if (columnConfig.columnType is EHDoubleColumnType) {
        inputFormatters = inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
        ];

        keyboardType = TextInputType.numberWithOptions(decimal: true);
      }

      return TextField(
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          focusNode: controller.dataGridSource.getFilterFocusNode(columnConfig),
          controller: EHTextEditingController(
              text: getColumnFilter(columnConfig.columnName).text),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            border: new OutlineInputBorder(),
            hintText: 'common.general.filterCondition'.tr,
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

  filterGridData(
      EHDataGridController controller, EHColumnConf columnConfig) async {
    await controller.dataGridSource.handleRefresh();

    controller.dataGridSource.getFilterFocusNode(columnConfig).requestFocus();
  }

  int getColumnIndex(EHColumnConf columnConfig) {
    return controller.dataGridSource.columnsConfig
        .where((c) => controller.dataGridSource
            .getColumnConfig(c.columnName)
            .columnType
            .hasFilter)
        .toList()
        .indexOf(columnConfig);
  }

  EHFilterInfo getColumnFilter(String columnName) {
    return controller.dataGridSource.columnFilters
        .where((e) => e.columnName == columnName)
        .first;
  }

  Widget _buildDataGrid() {
    // print(this.controller);
    // print(this.controller.dataPagerHeight);
    // print(this.controller.dataGridSource.pageSize!);

    return Obx(() => SfDataGrid(
        showCheckboxColumn: controller.showCheckbox,
        selectionMode: SelectionMode.multiple,
        //navigationMode: GridNavigationMode.row,
        controller: controller.dataGridSource.dataGridController,
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
          EHColumnConf column = this
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
        selectedItemColor: Colors.grey,
        itemBorderWidth: 0,
        itemBorderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Obx(() => SfDataPager(
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
            availableRowsPerPage: const <int>[25, 1, 50, 100, 200],
            pageCount: controller.dataGridSource.totalPageNumber.value == 0
                ? 1
                : controller.dataGridSource.totalPageNumber.value!,
            onRowsPerPageChanged: (int? rowsPerPage) async {
              this.controller.dataGridSource.pageSize!.value = rowsPerPage!;
              await this.controller.dataGridSource.handleRefresh();
            },
            direction: Axis.horizontal,
          )),
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

  sortColumn(EHColumnConf columnConfig) {
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
