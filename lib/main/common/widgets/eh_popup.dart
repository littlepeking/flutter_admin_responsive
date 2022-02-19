import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHDialog.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_datagrid/eh_datagrid_source.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHPopup extends EHStatelessWidget<EHPopupController> {
  EHPopup({
    Key? key,
    required EHPopupController controller,
  }) : super(key: key, controller: controller);

  Future<bool> _validate() async {
    bool isValid = controller.checkMustInput(key!, controller.text);

    if (!isValid) return false;

    List<Map> res = await controller._dataGridSource.getData(
      {controller.codeColumnName: controller.text},
      {},
      0,
      1,
    );
    if (res.length == 0) {
      controller.errorBucket![key] = 'The code cannot be found'.tr;
      return false;
    }

    isValid = await controller.validate();

    if (!isValid && EHUtilHelper.isEmpty(controller.errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    controller.iconButtonFocusNode.canRequestFocus = false;
    controller.iconButtonFocusNode.skipTraversal = true;

    return Obx(() => Container(
          padding: Responsive.isDesktop(context)
              ? EdgeInsets.symmetric(horizontal: 5)
              : EdgeInsets.symmetric(horizontal: 2),
          // height: 70,
          width: this.controller.width,
          child: Column(
            children: [
              EHEditLabel(
                mustInput: controller.mustInput,
                label: controller.label,
              ),
              Container(
                height: 25,
                child: Row(
                  children: [
                    Expanded(
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
                            if (!await _validate()) return;
                            List<Map> res =
                                await controller._dataGridSource.getData(
                              {controller.codeColumnName: controller.text},
                              {},
                              0,
                              1,
                            );
                            controller.onChanged!(controller.text, res.first);
                            controller.focusNode!.nextFocus();
                          },
                          controller: controller._textEditingController,
                          enabled: controller.enabled,
                          onChanged: (v) {
                            //TO DO: add check from backend do validate, if error then set column to empty
                          }),
                    ),
                    Container(
                      width: 30,
                      child: IconButton(
                          focusNode: controller.iconButtonFocusNode,
                          //   alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                          onPressed: () async {
                            await EHDialog.getPopupDialog(
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              Get.textTheme.caption!.color!)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: EHDataGrid(
                                        controller: EHDataGridController(
                                      dataGridSource:
                                          controller._dataGridSource,
                                      onRowSelected: (row) {
                                        controller.focusNode!.requestFocus();
                                        controller.focusNode!.nextFocus();
                                        controller.onChanged!(
                                            row[controller.codeColumnName]
                                                .toString(),
                                            row);
                                        controller.errorBucket![key] = '';
                                        Get.back();
                                      },
                                    )),
                                  ),
                                ),
                                focusNode: controller.focusNode,
                                title: controller.popupTitle);
                          },
                          icon: Icon(Icons.filter_center_focus)),
                    )
                  ],
                ),
              ),
              Obx(() => EHEditErrorInfo(
                  errorBucket: controller.errorBucket!.value,
                  errorFieldKey: key))
            ],
          ),
        ));
  }
}

class EHPopupController extends EHEditWidgetController {
  EHEditingController _textEditingController = EHEditingController();

  late EHDataGridSource _dataGridSource;

  late String codeColumnName;

  FocusNode iconButtonFocusNode = FocusNode();

  String popupTitle;

  String? queryCode;

  set text(val) {
    this._textEditingController.text = val;
  }

  String get text {
    return _textEditingController.text;
  }

  void Function(String code, Map row)? onChanged;

  EHDataGridSource getDateSource(
      EHDataGridSource? dataGridSource, String? queryCode) {
    if (dataGridSource == null && queryCode == null)
      throw Exception(
          'dataGridSource or queryCode must be provided one of them at least.');

    if (queryCode != null) {
      return EHDataGridSource(
          columnsConfig: [],
          getData: (
            Map<String, String> filters,
            Map<String, String> orderBy,
            int pageIndex,
            int pageSize,
          ) async =>
              <Map>[]);
    } else {
      return dataGridSource!;
    }
  }

  EHPopupController(
      {double? width,
      bool? autoFocus,
      //focusNode必须手工在controller中实例化并赋值给控件的focusNode属性,否则光标焦点跳转会有问题。
      //因为flutter要求focusNode必须在statefulWidget中进行设置，但目前框架暂时只使用statelessWidget，因此只能手工设置。
      FocusNode? focusNode,
      this.queryCode,
      required this.popupTitle,
      String label = '',
      String text = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      Future<bool> Function()? validate,
      String? codeColumnName,
      EHDataGridSource? dataGridSource,
      Map<Key?, String>? errorBucket})
      : super(
            validate: validate,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    this.autoFocus = autoFocus;
    this.label = label;
    this.text = text;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.codeColumnName = codeColumnName!; //未集成后台的code配置前，该字段需要手工传入
    this._dataGridSource = getDateSource(dataGridSource, queryCode);
  }
}
