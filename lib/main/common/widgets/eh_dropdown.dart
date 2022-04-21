import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/constants/layout_constant.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/theme_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../base/eh_controller.dart';
import '../utils/eh_refactor_helper.dart';

class EHDropdown extends EHStatelessWidget<EHDropDownController> {
  EHDropdown({required EHDropDownController controller})
      : super(key: controller.key, controller: controller);

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];

    if (!controller.isMenu && !items.contains('')) items.insert(0, '');

    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                controller.items.containsKey(item)
                    ? controller.items[item]!.tr
                    : ' ',
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                  color: Get.theme.inputDecorationTheme.enabledBorder!
                      .borderSide.color),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    int itemLength = controller.isMenu
        ? controller.items.length
        : controller.items.length + 1;
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
    return Obx(() => Container(
        padding: controller.padding ?? LayoutConstant.defaultEditWidgetPadding,
        width: controller.width,
        child: Column(
          children: [
            controller.showLabel && !controller.isMenu
                ? EHEditLabel(
                    mustInput: controller.mustInput,
                    label: controller.label.tr,
                  )
                : SizedBox(),
            Container(
              padding: controller.isMenu ? EdgeInsets.all(1) : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: !controller.isMenu
                    ? null
                    : ThemeController.instance.isDarkMode.value
                        ? Colors.grey[900]
                        : Colors.white,
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
                    onFocusChange: (focused) {
                      //set flag if current wiget is focused
                      controller.focused.value = focused;
                    },
                    child: DropdownButton2(
                      focusNode: controller.focusNode,
                      isExpanded: true,
                      // hint: Text(
                      //   'Select Item',
                      //   style: TextStyle(
                      //     //fontSize: 14,
                      //     color: Theme.of(context).hintColor,
                      //   ),
                      // ),
                      customButton: controller.isMenu
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(controller.label.tr),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  // color: Colors.red,
                                ),
                              ],
                            )
                          : null,
                      items: _addDividersAfterItems(
                          controller.items.keys.toList()),
                      customItemsIndexes: _getDividersIndexes(),
                      customItemsHeight: 4,
                      value: controller.isMenu
                          ? controller.items[0]
                          : controller.items
                                  .containsKey(controller._selectedValue.value)
                              ? controller._selectedValue.value
                              : '',
                      onChanged: controller.enabled
                          ? (v) async {
                              controller.setModelValue(v);
                              if (await controller._validate(v.toString())) {
                                controller.focusNode!.requestFocus();
                                controller.focusNode!.nextFocus();
                              }
                              //DO NOT depends on _validate result to trigger onChanges as it might broken the scenario without EHEditForm
                              //since model need binding result based on onChange. Downside is the onChange will be triggered each time even value is not as expected.
                              //The problem is we did not save displayValues in globalDisplayValueBucket like popup widget. We can continue enhance it when we really need it.
                              if (controller.onChanged != null)
                                controller.onChanged!(v.toString());
                            }
                          : null,
                      buttonHeight: 23,
                      buttonWidth: controller.width,
                      itemHeight: 23,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      dropdownWidth: controller.dropDownWidth ??
                          LayoutConstant.defaultDropDownItemWidth,
                      //dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        //color: Colors.redAccent,
                      ),
                      //offset: const Offset(0, 20),
                    )),
              ),
            ),
            controller.showErrorInfo && !controller.isMenu
                ? Obx(() => EHEditErrorInfo(
                    // ignore: invalid_use_of_protected_member
                    error: EHController.getWidgetError(
                        controller.errorBucket!, key!)))
                : SizedBox()
          ],
        )));
  }
}

class EHDropDownController extends EHEditableWidgetController {
  late Map<String, String> items;

  RxString _selectedValue = ''.obs;

  bool showLabel;

  bool showErrorInfo;

  RxBool focused = false.obs;

  EdgeInsets? padding;

  get selectedValue {
    return _selectedValue.value;
  }

  set selectedValue(v) {
    _selectedValue.value = v;
  }

  ValueChanged<String>? onChanged;
  bool isMenu;

  late String _bindingValue;

  double? dropDownWidth;

  EHDropDownController(
      {Key? key,
      EHModel? model,
      String? bindingFieldName,
      double? width,
      this.dropDownWidth,
      this.isMenu = false,
      EdgeInsets? padding,
      bool autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      String bindingValue = '',
      bool enabled = true,
      bool mustInput = false,
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
            focusNode: focusNode,
            errorBucket: errorBucket,
            onValidate: onValidate) {
    this.width = isMenu ? null : LayoutConstant.editWidgetSize;
    this.items = new Map<String, String>.from(items);
    if (!this.items.containsKey('') && !isMenu) this.items[''] = '';

    this._bindingValue = bindingValue;

    init();
  }

  @override
  init() {
    String? value;
    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      value =
          EHRefactorHelper.getFieldValue(model!, bindingFieldName!) as String?;
    } else {
      value = _bindingValue;
    }

    this.selectedValue = value ?? '';
  }

  Future<bool> _validate(String value) async {
    EHController.setWidgetError(errorBucket!, key!, '');

    bool isValid = checkMustInput(key!, value, emptyValue: '');

    if (!isValid) return false;

    isValid = await onValidate(this);

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  validateWidget() async {
    return await _validate(selectedValue);
  }
}
