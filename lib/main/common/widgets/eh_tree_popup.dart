import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/main/common/constants/layout_constant.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_dialog.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tree_view/eh_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/eh_controller.dart';
import 'eh_tree_view/eh_tree_node.dart';

class EHTreePopup extends EHEditableWidget<EHTreePopupController> {
  EHTreePopup({
    required EHTreePopupController controller,
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
                              await controller
                                  .doValidateAndTriggerCompleteEvent(false);
                            }
                            controller.isValidated = false;
                          }
                        },
                        canRequestFocus: false,
                        child: TextField(
                            autofocus: controller.autoFocus,
                            focusNode: FocusNode(),
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: new OutlineInputBorder(),
                            ),
                            onEditingComplete: () async {
                              await controller
                                  .doValidateAndTriggerCompleteEvent(true);
                              controller.isValidated = true;
                            },
                            controller: controller._textEditingController,
                            enabled: false),
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

                            await controller
                                .loadTreeData(controller.treeController);

                            bool? result = await EHDialog.showPopupDialog(
                                Card(
                                  elevation: 10,
                                  margin: Responsive.isMobile(Get.context!)
                                      ? EdgeInsets.symmetric(horizontal: 3)
                                      : EdgeInsets.symmetric(horizontal: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: EHTreeView(
                                        controller: controller.treeController),
                                  ),
                                ),
                                focusNode: controller.iconButtonFocusNode,
                                title: controller.popupTitle);

                            print('result: $result');
                          },
                          icon: controller.enabled
                              ? Icon(Icons.lan)
                              : Icon(
                                  Icons.lan,
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

class EHTreePopupController extends EHEditableWidgetController {
  EHTextEditingController _textEditingController = EHTextEditingController();

  FocusNode iconButtonFocusNode = FocusNode();

  String popupTitle;

  late dynamic bindingData;
  bool isValidated = false;

  late EHTreeController treeController;

  set displayText(String? val) {
    this._textEditingController.text = val ?? '';
  }

  String get displayText {
    return _textEditingController.text;
  }

  void Function(dynamic data)? onTreeNodeTap;

  String Function(dynamic data) getDisplayValue;

  Future<void> Function(EHTreeController treeController) loadTreeData;

  EHTreePopupController(
      {Key? key,
      double? width,
      bool autoFocus = false,
      //focusNode必须手工在controller中实例化并赋值给控件的focusNode属性,否则光标焦点跳转会有问题。
      //因为flutter要求focusNode必须在statefulWidget中进行设置，但目前框架暂时只使用statelessWidget，因此只能手工设置。
      FocusNode? focusNode,
      required this.popupTitle,
      String label = '',
      this.bindingData,
      required this.getDisplayValue,
      bool enabled = true,
      bool mustInput = false,
      this.onTreeNodeTap,
      required this.loadTreeData,
      EHEditableWidgetOnValidate? onValidate,
      List<EHTreeNode> treeNodeDataList = const [],
      Map<Key?, RxString>? errorBucket})
      : super(
            key: key,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket,
            onValidate: onValidate) {
    init();

    treeController = EHTreeController(
      onTreeNodeTap: (EHTreeNode node) {
        EHController.setWidgetDisplayValue(key!, '');

        if (getInitValue() != node.displayName) {
          if (onTreeNodeTap != null) onTreeNodeTap!(node.data);
        }

        focusNode!.requestFocus();
        //focusNode!.nextFocus();

        EHController.setWidgetError(this.errorBucket!, key!, '');

        Get.back(result: true);
      },
      treeNodeDataList: treeNodeDataList.obs,
    );
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

  dynamic getInitValue() {
    return getDisplayValue(bindingData);
  }

  Future<bool> _validate() async {
    EHController.setWidgetDisplayValue(key!, displayText);
    bool isValid = checkMustInput(key!, displayText);

    if (!isValid) {
      return false;
    } else {
      isValid = await onValidate(this);

      if (!isValid && EHUtilHelper.isEmpty(errorBucket![key]))
        throw Exception(
            'Error: Must provide error message in errorBucket while validate failed');
      if (isValid) EHController.setWidgetDisplayValue(key!, '');
      return isValid;
    }
  }

  @override
  Future<bool> validateWidget() async {
    return await _validate();
  }

  doValidateAndTriggerCompleteEvent(bool goNextFocusIfValid) async {
    if (await _validate()) {
      if (getInitValue() !=
          treeController.selectedTreeNode.value?.displayName) {
        if (onTreeNodeTap != null)
          onTreeNodeTap!(treeController.selectedTreeNode.value?.data);
      }

      clearWidgetInfo();

      if (goNextFocusIfValid) focusNode!.nextFocus();
    }
  }
}
