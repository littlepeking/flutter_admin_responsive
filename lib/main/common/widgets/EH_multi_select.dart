import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

class _TheState {}

class EHMultiSelect extends EHStatelessWidget<EHMultiSelectController> {
  EHMultiSelect(
      {required Key key,
      ValueChanged<List<String>>? onChanged,
      required EHMultiSelectController controller})
      : super(key: key, controller: controller);

  final _theState = RM.inject(() =>
      _TheState()); //Get idea from  multiselect: ^0.0.4 to fix werid obx build error temporarily ...
  /*
      This Obx widget cannot be marked as needing to build because the framework is already in the process of building widgets. A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
      The widget on which setState() or markNeedsBuild() was called was: Obx
  */

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> keys) {
    List<DropdownMenuItem<String>> _menuItems = [];

    keys.forEach((itemKey) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: itemKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  _theState.rebuilder(() {
                    return Checkbox(
                        value: controller.selectedValues.contains(itemKey),
                        onChanged: (isSelected) {
                          if (isSelected!) {
                            controller.selectedValues.add(itemKey);
                            _theState.notify();
                            _validate(controller.selectedValues);
                            controller.onChanged!(controller.selectedValues);
                          } else {
                            controller.selectedValues.remove(itemKey);
                            _theState.notify();
                            _validate(controller.selectedValues);
                            controller.onChanged!(controller.selectedValues);
                          }
                        });
                  }),
                  Text(
                    controller.items.containsKey(itemKey)
                        ? controller.items[itemKey]!
                        : ' ',
                    style: const TextStyle(
                      fontSize: 14,
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
      value: '',
      child: SizedBox(
        height: 0,
      ),
    ));

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
        padding: Responsive.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 5)
            : EdgeInsets.symmetric(horizontal: 2),
        // height: 70,
        width: controller.width,
        child: Column(
          children: [
            EHEditLabel(
              mustInput: controller.mustInput,
              label: controller.label,
            ),
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
                    onFocusChange: (focused) {
                      //change border color when dropdown widget is focused or not
                      controller.focused.value = focused;
                    },
                    child: Stack(children: [
                      Container(
                        padding: EdgeInsets.only(left: 5, top: 3, right: 15),
                        height: 23.4,
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
                          value: '',
                          onChanged: controller.enabled ? (x) {} : null,
                          buttonHeight: 23.4,
                          buttonWidth: controller.width,
                          itemHeight: 23,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0)),
                    ])),
              ),
            ),
            Obx(() => EHEditErrorInfo(
                errorBucket: controller.errorBucket!.value, errorFieldKey: key))
          ],
        ));
  }

  Future<bool> _validate(List<String> value) async {
    bool isValid = controller.checkMustInput(key!, value, emptyValue: '');

    if (!isValid) return false;

    isValid = await controller.validate();

    if (!isValid && EHUtilHelper.isEmpty(controller.errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
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

class EHMultiSelectController extends EHEditWidgetController {
  late Map<String, String> items;

  RxList<String> _selectedValues = <String>[].obs;

  RxBool focused = false.obs;

  RxList<String> get selectedValues {
    return _selectedValues;
  }

  set selectedValues(List<String> value) {
    _selectedValues.value = value;
  }

  ValueChanged<List<String>>? onChanged;

  EHMultiSelectController({
    double? width,
    bool autoFocus = false,
    required FocusNode focusNode,
    String label = '',
    List<String> selectedValues = const [],
    bool enabled = true,
    bool mustInput = false,
    this.onChanged,
    Future<bool> Function()? validate,
    Map<Key?, String>? errorBucket,
    required Map<String, String> items,
  }) : super(
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            validate: validate,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    this.items = items;
    this.selectedValues = selectedValues;
  }
}
