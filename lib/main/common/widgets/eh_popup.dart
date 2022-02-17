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
                          onEditingComplete: () {
                            // Move the focus to the next node explicitly.
                            if (controller.onEditingComplete == null) {
                              FocusScope.of(context).nextFocus();
                            } else {
                              controller.onEditingComplete!(context);
                            }
                          },
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
                            controller.onChanged!(v);
                          }),
                    ),
                    Container(
                      width: 30,
                      child: IconButton(
                          //   alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            EHDialog.getPopupDialog(EHDataGrid(
                              controller: controller._dataGridController,
                            ));
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

  late EHDataGridController _dataGridController;

  GlobalKey<State<Tooltip>> tooltipKey = GlobalKey();

  double width;

  Map? errorBucket;

  FocusNode? focusNode;

  RxBool _autoFocus = false.obs;

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

  ValueChanged<String>? onChanged;
  Function? onEditingComplete;

  EHPopupController(
      {this.width = 200,
      bool? autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      String text = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      this.onEditingComplete,
      EHDataGridController? dataGridController,
      Map? errorBucket}) {
    this.autoFocus = autoFocus;
    this.label = label;
    this.text = text;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.errorBucket = errorBucket;
    this.focusNode = focusNode;
    this._dataGridController = dataGridController ??
        EHDataGridController(
            dataGridSource: EHDataGridSource(
                columnsConfig: <EHDataGridColumnConfig>[],
                getData: (
                  Map<String, String> filters,
                  Map<String, String> _orderBy,
                  int pageIndex,
                  int pageSize,
                ) =>
                    <Map>[]));
  }
}
