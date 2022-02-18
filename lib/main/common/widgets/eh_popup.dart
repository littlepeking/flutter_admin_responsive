import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
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

import 'eh_datagrid/eh_datagrid_column_config.dart';

//注意：如果EHTextField设置了EHTextFieldController，除KEY外的其他属性将不生效。EHTextFieldController与其他属性只允许二选一。
class EHPopup extends EHStatelessWidget<EHPopupController> {
  EHPopup({
    Key? key,
    EHPopupController? controller,
  }) : super(key: key, controller: controller ?? EHPopupController());

  @override
  Widget build(BuildContext context) {
    controller.iconButtonFocusNode.canRequestFocus = false;
    controller.iconButtonFocusNode.skipTraversal = true;
    if (controller.errorBucket == null)
      controller.errorBucket = EHController.globalErrorBucket;

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
                          // onEditingComplete: () {
                          //   // // Move the focus to the next node explicitly.
                          //   // if (controller.onEditingComplete == null) {
                          //   //   Get.focusScope!.nextFocus();
                          //   //   // controller.focusNode!.nextFocus();
                          //   // } else {
                          //   //   controller.onEditingComplete!(context);
                          //   // }
                          // },
                          controller: controller._textEditingController,
                          enabled: controller.enabled,
                          onChanged: (v) {
                            if (controller.mustInput) {
                              if (EHUtilHelper.isEmpty(v)) {
                                controller.errorBucket![key] =
                                    'This field cannot be empty'.tr;
                              } else {
                                controller.errorBucket![key] = '';
                              }
                            }
                            controller.onChanged!(v, Map());
                            controller.focusNode!.nextFocus();
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
                                          width: 2,
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
              EHEditErrorInfo(
                  errorBucket: controller.errorBucket!, errorFieldKey: key)
            ],
          ),
        ));
  }
}

class EHPopupController extends EHController {
  EHEditingController _textEditingController = EHEditingController();

  late EHDataGridSource _dataGridSource;

  GlobalKey<State<Tooltip>> tooltipKey = GlobalKey();

  double width;

  late String codeColumnName;

  FocusNode iconButtonFocusNode = FocusNode();

  Map? errorBucket;

  FocusNode? focusNode;

  RxBool _autoFocus = false.obs;

  var popupTitle;

  get autoFocus {
    return _autoFocus.value;
  }

  set autoFocus(v) {
    _autoFocus.value = v;
  }

  RxBool _mustInput = false.obs;

  get mustInput {
    return _mustInput.value;
  }

  set mustInput(v) {
    _mustInput.value = v;
  }

  RxString _label = ''.obs;

  get label {
    return _label.value;
  }

  set label(v) {
    _label.value = v;
  }

  RxBool _enabled = true.obs;

  get enabled {
    return _enabled.value;
  }

  set enabled(v) {
    _enabled.value = v;
  }

  set text(val) {
    this._textEditingController.text = val;
  }

  String get text {
    return _textEditingController.text;
  }

  void Function(String code, Map row)? onChanged;
  Function? onEditingComplete;

  EHPopupController(
      {this.width = 200,
      bool? autoFocus = false,
      //focusNode必须手工在controller中实例化并赋值给控件的focusNode属性,否则光标焦点跳转会有问题。
      //因为flutter要求focusNode必须在statefulWidget中进行设置，但目前框架暂时只使用statelessWidget，因此只能手工设置。
      this.focusNode,
      this.popupTitle,
      String label = '',
      String text = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      this.onEditingComplete,
      String? codeColumnName,
      EHDataGridSource? dataGridSource,
      Map? errorBucket}) {
    this.autoFocus = autoFocus;
    this.label = label;
    this.text = text;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.errorBucket = errorBucket;
    this.focusNode = focusNode;
    this.codeColumnName = codeColumnName!; //未集成后台的code配置前，该字段需要手工传入
    this._dataGridSource = dataGridSource ??
        EHDataGridSource(
            columnsConfig: <EHDataGridColumnConfig>[],
            getData: (
              Map<String, String> filters,
              Map<String, String> _orderBy,
              int pageIndex,
              int pageSize,
            ) =>
                <Map>[]);
  }
}
