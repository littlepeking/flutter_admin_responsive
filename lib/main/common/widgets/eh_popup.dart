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
                            if (await controller._validate()) {
                              Map<String, Object?> codeFilters =
                                  controller._dataGridSource.filters;
                              codeFilters[controller.codeColumnName] =
                                  controller.text;

                              List<Map> res =
                                  await controller._dataGridSource.getData(
                                codeFilters,
                                {},
                                0,
                                1,
                              );
                              if (res.isNotEmpty) {
                                controller.setModelValue(controller.text);
                                if (controller.onChanged != null)
                                  controller.onChanged!(
                                      controller.text, res.first);
                              } else {
                                controller.setModelValue(null);
                                if (controller.onChanged != null)
                                  controller.onChanged!(null, null);
                              }
                              EHController.globalDisplayValueBucket
                                  .remove(controller.key!);
                            } else {
                              EHController.globalDisplayValueBucket[
                                  controller.key!] = controller.text;
                            }
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
                              controller.focusNode!.nextFocus();
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
                            controller._dataGridSource.handleRefresh();
                            bool result = await EHDialog.showPopupDialog(
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
                                        EHController.globalDisplayValueBucket
                                            .remove(controller.key!);
                                        controller.setModelValue(
                                            row[controller.codeColumnName]
                                                .toString());

                                        controller.focusNode!.requestFocus();
                                        controller.focusNode!.nextFocus();

                                        if (controller.onChanged != null)
                                          controller.onChanged!(
                                              row[controller.codeColumnName]
                                                  .toString(),
                                              row);
                                        controller
                                            .errorBucket![controller.key] = '';
                                        Get.back(result: true);
                                      },
                                    )),
                                  ),
                                ),
                                focusNode: controller.focusNode,
                                title: controller.popupTitle);

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
                  errorBucket: controller.errorBucket!.value,
                  errorFieldKey: key))
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

  String? queryCode;

  late String? _bindingValue;

  set text(String? val) {
    this._textEditingController.text = val ?? '';
  }

  String get text {
    return _textEditingController.text;
  }

  void Function(String? code, Map? row)? onChanged;

  EHDataGridSource getDateSource(
      EHDataGridSource? dataGridSource, String? queryCode) {
    if (dataGridSource == null && queryCode == null)
      throw Exception(
          'dataGridSource or queryCode must be provided one of them at least.');

    if (queryCode != null) {
      return EHDataGridSource(
          loadDataAtInit: false,
          columnsConfig: [],
          getData: (
            Map<String, Object?> filters,
            Map<String, String> orderBy,
            int pageIndex,
            int pageSize,
          ) async =>
              <Map>[]);
    } else {
      dataGridSource!.loadDataAtInit = false;
      return dataGridSource;
    }
  }

  EHPopupController(
      {Key? key,
      EHModel? model,
      String? bindingFieldName,
      double? width,
      bool autoFocus = false,
      //focusNode必须手工在controller中实例化并赋值给控件的focusNode属性,否则光标焦点跳转会有问题。
      //因为flutter要求focusNode必须在statefulWidget中进行设置，但目前框架暂时只使用statelessWidget，因此只能手工设置。
      FocusNode? focusNode,
      this.queryCode,
      required this.popupTitle,
      String label = '',
      String? bindingValue = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      Future<bool> Function()? validate,
      String? codeColumnName,
      EHDataGridSource? dataGridSource,
      Map<Key?, String>? errorBucket})
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
            errorBucket: errorBucket) {
    this.validate = validate ?? () async => true;

    _bindingValue = bindingValue;

    init();

    this.codeColumnName = codeColumnName!; //未集成后台的code配置前，该字段需要手工传入
    this._dataGridSource = getDateSource(dataGridSource, queryCode);
  }

  @override
  init() {
    String? initDisplayValue;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      initDisplayValue =
          EHRefactorHelper.getFieldValue(model!, bindingFieldName!) as String?;
    } else {
      initDisplayValue = _bindingValue;
    }

    if (key != null && EHController.globalDisplayValueBucket[key] != null) {
      this.text = EHController.globalDisplayValueBucket[key]!;
    } else {
      this.text = initDisplayValue ?? '';
    }
  }

  Future<bool> _validate() async {
    bool isValid = checkMustInput(key!, text);

    if (!isValid) return false;

    Map<String, Object?> codeFilters = _dataGridSource.filters;
    codeFilters[codeColumnName] = text;

    List<Map> res = await _dataGridSource.getData(
      codeFilters,
      {},
      0,
      1,
    );
    if (res.length == 0) {
      errorBucket![key] = 'The code cannot be found'.tr + ':' + text;
      return false;
    }

    isValid = await validate();

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  Future<bool> validateWidget() async {
    return _validate();
  }
}
