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

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_edit_widget_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_editable_widget.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_model.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/constants/layout_constant.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/utils/eh_util_helper.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/common/eh_edit_error_info.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../../enhantec_ui_framework/base/eh_controller.dart';
import '../../../enhantec_ui_framework/utils/eh_refactor_helper.dart';

class _TheState {}

class EHMultiSelect extends EHEditableWidget<EHMultiSelectController> {
  EHMultiSelect({required EHMultiSelectController controller})
      : super(key: controller.key, controller: controller);

  final _theState = RM.inject(() =>
      _TheState()); //Get idea from  multiselect: ^0.0.4 to fix werid obx build error temporarily ...
  /*
      This Obx widget cannot be marked as needing to build because the framework is already in the process of building widgets. A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
      The widget on which setState() or markNeedsBuild() was called was: Obx
  */

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> keys) {
    List<DropdownMenuItem<String>> _menuItems = [];

    keys.sort();

    keys.where((e) => e != '-999').forEach((itemKey) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: itemKey,
            enabled: false, //multi select can only be check and not be tapped
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  // ignore: deprecated_member_use
                  _theState.rebuilder(() {
                    return ExcludeFocus(
                      child: Checkbox(
                          value: controller.selectedValues.contains(itemKey),
                          onChanged: (isSelected) async {
                            isSelected!
                                ? controller.selectedValues.add(itemKey)
                                : controller.selectedValues.remove(itemKey);
                            controller.setModelValue(controller.selectedValues);
                            _theState.notify();
                            await controller
                                ._validate(controller.selectedValues);
                            //DO NOT depends on _validate result to trigger onChanges as it might broken the scenario without EHEditForm
                            //since model need binding result based on onChange. Downside is the onChange will be triggered each time even value is not as expected.
                            //The problem is we did not save displayValues in globalDisplayValueBucket like popup widget. We can continue enhance it when we really need it.
                            if (controller.onChanged != null)
                              controller.onChanged!(controller.selectedValues);
                          }),
                    );
                  }),
                  Expanded(
                    child: Text(
                      controller.items.containsKey(itemKey)
                          ? controller.items[itemKey]!
                          : ' ',
                      style: const TextStyle(
                          //fontSize: 14,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (itemKey != keys.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                  color: Get.theme.inputDecorationTheme.enabledBorder!
                      .borderSide.color),
            ),
        ],
      );
    });

    _menuItems.add(DropdownMenuItem<String>(
        enabled: false,
        //add DEFAULT ITEM as dropdownbutton2 need init value and it cannot be empty.
        value: '-999',
        child: SizedBox(
          height: 0,
        )));
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    int itemLength = controller.items.length + 1;
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (itemLength * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: LayoutConstant.defaultEditWidgetPadding,
        // height: 70,
        width: controller.width,
        child: Column(
          children: [
            controller.showLabel
                ? EHEditLabel(
                    mustInput: controller.mustInput,
                    label: controller.label.tr,
                  )
                : SizedBox(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: controller.focused.value
                    ? Border.all(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder!
                            .borderSide
                            .color,
                        style: BorderStyle.solid,
                        width: 1)
                    : Border.all(
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder!
                            .borderSide
                            .color,
                        style: BorderStyle.solid,
                        width: 1),
              ),
              child: DropdownButtonHideUnderline(
                child: Focus(
                    canRequestFocus: false,
                    onFocusChange: (hasFocus) {
                      //change border color when dropdown widget is focused or not
                      controller.focused.value = hasFocus;
                    },
                    child: Stack(children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 3, right: 15),
                        height: 23,
                        child: Text(
                          getDisplayValues(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      DropdownButton2(
                        focusNode: controller.focusNode,
                        isExpanded: true,
                        items: _addDividersAfterItems(
                            controller.items.keys.toList()),
                        customItemsIndexes: _getDividersIndexes(),
                        customItemsHeight: 4,
                        value:
                            '-999', //default value to satisfy the dropdown2 param
                        onChanged: controller.enabled ? (x) {} : null,
                        buttonHeight: 23,
                        buttonWidth: controller.width,
                        itemHeight: 23,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        dropdownWidth: LayoutConstant.defaultDropDownItemWidth,
                        //dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          //color: Colors.redAccent,
                        ),
                      ),
                    ])),
              ),
            ),
            controller.showErrorInfo
                ? Obx(() => EHEditErrorInfo(
                    // ignore: invalid_use_of_protected_member
                    error: EHController.getWidgetError(
                        controller.errorBucket!, key!)))
                : SizedBox()
          ],
        ));
  }

  getDisplayValues() {
    if (controller.selectedValues.length > 0) {
      controller.selectedValues.sort();

      String res = '';
      controller.selectedValues.forEach((String element) {
        if (controller.selectedValues.indexOf(element) != 0) res += ',';
        res += controller.items[element]!;
      });

      return res;
    } else {
      return '';
    }
  }
}

class EHMultiSelectController extends EHEditableWidgetController {
  late Map<String, String> items;

  EdgeInsets padding;

  bool showLabel;

  bool showErrorInfo;

  List<String> selectedValues = <String>[];

  late List<String> _bindingValue;

  RxBool focused = false.obs;

  ValueChanged<List<String>>? onChanged;

  EHMultiSelectController(
      {Key? key,
      EHModel? model,
      String? bindingFieldName,
      double? width,
      this.padding = const EdgeInsets.symmetric(horizontal: 5),
      bool autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      List<String> bindingValue = const [],
      bool enabled = true,
      bool mustInput = false,
      bool allowSelectEmpty = false,
      this.onChanged,
      EHEditableWidgetOnValidate? onValidate,
      Map<Key?, RxString>? errorBucket,
      required Map<String, String> items,
      this.showErrorInfo = true,
      this.showLabel = true})
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
    this.items = new Map<String, String>.from(items);
    if (allowSelectEmpty && !this.items.containsKey('[__EMPTY__]'))
      this.items['[__EMPTY__]'] = '[Blank]'.tr; // placeholder for empty value
    this.items['-999'] = 'add item to prevent dropdown2 throw error ';
    this._bindingValue = bindingValue;

    init();
  }

  @override
  init() {
    List<String>? value;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      value = (EHRefactorHelper.getFieldValue(model!, bindingFieldName!) ??
          <String>[]) as List<String>;
    } else {
      value = _bindingValue;
    }

    this.selectedValues = value;
  }

  Future<bool> _validate(List<String> value) async {
    bool isValid = checkMustInput(key!, value, emptyValue: '');

    if (!isValid) return false;

    isValid = await onValidate(this);

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  Future<bool> validateWidget() async {
    return await _validate(selectedValues);
  }
}
