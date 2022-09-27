import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/constants/layout_constant.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_dialog.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/eh_controller.dart';
import '../utils/eh_refactor_helper.dart';
import 'eh_datagrid/eh_datagrid_filter_data.dart';

class EHPopup extends EHEditableWidget<EHPopupController> {
  EHPopup({
    required EHPopupController controller,
  }) : super(key: controller.key, controller: controller);

  @override
  Widget build(BuildContext context) {
    controller.iconButtonFocusNode.canRequestFocus = false;
    controller.iconButtonFocusNode.skipTraversal = true;

    return Obx(() => Container(
          padding: LayoutConstant.defaultEditWidgetPadding,
          // height: 70,
          width: this.controller.width,
          child: Column(
            children: [
              EHEditLabel(
                mustInput: controller.mustInput,
                label: controller.label.tr,
              ),
              Container(
                height: 25,
                child: Row(
                  children: [
                    Expanded(
                      child: Focus(
                        onFocusChange: (hasFocus) async {
                          if (!hasFocus) {
                            if (!controller.isValidated) {
                              await controller.doValidateAndUpdateModel(false);
                            }
                            controller.isValidated = false;
                          }
                        },
                        canRequestFocus: false,
                        child: TextField(
                            autofocus: controller.autoFocus,
                            focusNode: controller.focusNode,
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: new OutlineInputBorder(),
                            ),
                            onEditingComplete: () async {
                              await controller.doValidateAndUpdateModel(true);
                              controller.isValidated = true;
                            },
                            controller: controller._textEditingController,
                            enabled: controller.enabled),
                      ),
                    ),
                    Container(
                      width: 30,
                      child: IconButton(
                          focusNode: controller.iconButtonFocusNode,
                          //   alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            if (!controller.enabled) return;
                            await controller._dataGridSource.handleRefresh();
                            bool? result = await EHDialog.showPopupDialog(
                                Card(
                                  elevation: 10,
                                  margin: Responsive.isMobile(Get.context!)
                                      ? EdgeInsets.symmetric(horizontal: 3)
                                      : EdgeInsets.symmetric(horizontal: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: EHDataGrid(
                                        controller: EHDataGridController(
                                      dataGridSource:
                                          controller._dataGridSource,
                                      onRowSelected: (row) {
                                        EHController.setWidgetDisplayValue(
                                            controller.key!, '');

                                        if (controller.getInitValue() !=
                                            row[controller.codeColumnName]) {
                                          controller.setModelValue(
                                              row[controller.codeColumnName]
                                                  .toString());
                                          if (controller.onEditingComplete !=
                                              null)
                                            controller.onEditingComplete!(
                                                row[controller.codeColumnName]
                                                    .toString(),
                                                row);
                                        }

                                        controller.focusNode!.requestFocus();
                                        controller.focusNode!.nextFocus();

                                        EHController.setWidgetError(
                                            controller.errorBucket!,
                                            controller.key!,
                                            '');

                                        Get.back(result: true);
                                      },
                                    )),
                                  ),
                                ),
                                focusNode: controller.focusNode,
                                titleMsgKey: controller.popupTitle);

                            print('result: $result');
                          },
                          icon: controller.enabled
                              ? Icon(Icons.search)
                              : Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                )),
                    )
                  ],
                ),
              ),
              Obx(() => EHEditErrorInfo(
                  // ignore: invalid_use_of_protected_member
                  error: EHController.getWidgetError(
                      controller.errorBucket!, key!))),
            ],
          ),
        ));
  }
}

class EHPopupController extends EHEditableWidgetController {
  EHTextEditingController _textEditingController = EHTextEditingController();

  late EHDataGridSource _dataGridSource;

  late String codeColumnName;

  FocusNode iconButtonFocusNode = FocusNode();

  String popupTitle;

  late String? _bindingValue;

  bool isValidated = false;

  set displayText(String? val) {
    this._textEditingController.text = val ?? '';
  }

  late String? validatedResult;
  late Map? validatedRow;

  String get displayText {
    return _textEditingController.text;
  }

  void Function(String? code, Map? row)? onEditingComplete;

  // EHDataGridSource getDateSource(EHDataGridSource dataGridSource) {
  //   // throw Exception(
  //   //     'dataGridSource or queryCode must be provided one of them at least.');

  //   return dataGridSource;
  // }

  EHPopupController(
      {Key? key,
      EHModel? model,
      String? bindingFieldName, // column name of data model for binding
      double? width,
      bool autoFocus = false,
      //focusNode必须手工在controller中实例化并赋值给控件的focusNode属性,否则光标焦点跳转会有问题。
      //因为flutter要求focusNode必须在statefulWidget中进行设置，但目前框架暂时只使用statelessWidget，因此只能手工设置。
      FocusNode? focusNode,
      required this.popupTitle,
      String label = '',
      String? bindingValue = '',
      bool enabled = true,
      bool mustInput = false,
      this.onEditingComplete,
      EHEditableWidgetOnValidate? onValidate,
      String?
          codeColumnName, // column name of popup grid data source and after user select a row, it will bring back the code column value to model.bindingFieldName.
      required EHDataGridSource dataSource,
      Map<Key?, RxString>? errorBucket})
      : super(
            key: key,
            model: model,
            bindingFieldName: bindingFieldName,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket,
            onValidate: onValidate) {
    _bindingValue = bindingValue;

    init();

    this.codeColumnName = codeColumnName!;
    //prevent refresh Exception (pager building will trigger refresh again, so we need make sure popup does not trigger it at that time)
    dataSource.loadDataAtInit = false;
    this._dataGridSource = dataSource;
  }

  @override
  init() {
    String? initDisplayValue = getInitValue();

    //if exists Widget Error means displayValue should be used even it is empty. e.g.must input error
    if (key != null &&
        (!EHUtilHelper.isEmpty(EHController.getWidgetDisplayValue(key!)) ||
            !EHUtilHelper.isEmpty(
                EHController.getWidgetError(errorBucket!, key!)))) {
      displayText = EHController.getWidgetDisplayValue(key!);
    } else {
      this.displayText = initDisplayValue ?? '';
    }
  }

  String? getInitValue() {
    String? initDisplayValue;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      initDisplayValue =
          EHRefactorHelper.getFieldValue(model!, bindingFieldName!) as String?;
    } else {
      initDisplayValue = _bindingValue;
    }

    return initDisplayValue;
  }

  Future<bool> _validate() async {
    EHController.setWidgetDisplayValue(key!, displayText);
    bool isValid = checkMustInput(key!, displayText);

    if (!isValid) {
      return false;
    } else if (EHUtilHelper.isEmpty(displayText)) {
      validatedResult = null;
      validatedRow = null;
      EHController.setWidgetDisplayValue(key!, '');
      return true;
    } else {
      List<EHDataGridFilterData> filters = _dataGridSource.filters;
      getFilter(filters, codeColumnName).value = displayText;

      Map<String, dynamic> pageData = await _dataGridSource.getData(
        {},
        filters,
        {},
        0,
        2, //to test if multiple records related to same code
      );

      List<Map<String, dynamic>> res =
          List<Map<String, dynamic>>.from(pageData['records']);

      print('3:' + displayText);
      if (res.length == 0) {
        EHController.setWidgetError(errorBucket!, key!,
            'common.error.noRecordRelated2Code'.tr + ':' + displayText);

        return false;
      }
      if (res.length > 1) {
        EHController.setWidgetError(errorBucket!, key!,
            'common.error.multiRecordsRelated2Code'.tr + ':' + displayText);

        return false;
      } else {
        validatedResult = displayText;
        validatedRow = res[0];
        isValid = await onValidate(this);

        if (!isValid && EHUtilHelper.isEmpty(errorBucket![key]))
          throw Exception(
              'Error: Must provide error message in errorBucket while validate failed');
        if (isValid) EHController.setWidgetDisplayValue(key!, '');
        return isValid;
      }
    }
  }

  EHDataGridFilterData getFilter(
      List<EHDataGridFilterData> filters, String columnName) {
    Iterable<EHDataGridFilterData> filterDataList =
        filters.where((f) => f.columnName == columnName);

    if (filterDataList.length > 0) {
      return filterDataList.first;
    } else {
      EHDataGridFilterData filter =
          EHDataGridFilterData(columnName: columnName, type: 'string');
      filters.add(filter);
      return filter;
    }
  }

  @override
  Future<bool> validateWidget() async {
    return doValidateAndUpdateModel(false);
  }

  doValidateAndUpdateModel(bool goNextFocusIfValid) async {
    if (await _validate()) {
      if (getInitValue() != validatedResult) {
        setModelValue(validatedResult);
        if (onEditingComplete != null)
          onEditingComplete!(validatedResult, validatedRow);
      }

      clearWidgetInfo();

      if (goNextFocusIfValid) focusNode!.nextFocus();
    }
  }
}
