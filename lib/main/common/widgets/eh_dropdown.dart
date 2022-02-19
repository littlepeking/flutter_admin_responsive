import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHDropdown extends EHStatelessWidget<EHDropDownController> {
  EHDropdown(
      {Key? key,
      ValueChanged<String>? onChanged,
      required EHDropDownController controller})
      : super(key: key, controller: controller);

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];

    if (!items.contains('-1')) items.insert(0, '-1');

    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                controller.items.containsKey(item)
                    ? controller.items[item]!
                    : ' ',
                style: const TextStyle(
                  fontSize: 14,
                ),
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
    return Obx(() => Container(
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
                      controller.focused.value = focused;
                    },
                    child: DropdownButton2(
                      focusNode: controller.focusNode,
                      isExpanded: true,
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _addDividersAfterItems(
                          controller.items.keys.toList()),
                      customItemsIndexes: _getDividersIndexes(),
                      customItemsHeight: 4,
                      value: controller.items
                              .containsKey(controller._selectedValue.value)
                          ? controller._selectedValue.value
                          : '-1',
                      onChanged: controller.enabled
                          ? (v) async {
                              if (controller.mustInput) {
                                if (v == "-1") {
                                  controller.errorBucket![key] =
                                      'This field cannot be empty'.tr;
                                } else {
                                  controller.errorBucket![key] = '';
                                }
                              }
                              // await _validate(v.toString());
                              Map<Key, String> c =
                                  EHController.globalErrorBucket;
                              controller.onChanged!(v.toString());
                              controller.focusNode!.nextFocus();
                            }
                          : null,
                      buttonHeight: 23.4,
                      buttonWidth: controller.width,
                      itemHeight: 23,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    )),
              ),
            ),
            Obx(() => EHEditErrorInfo(
                errorBucket: controller.errorBucket!.value, errorFieldKey: key))
          ],
        )));
  }

  Future<bool> _validate(String value) async {
    bool isValid = controller.checkMustInput(key!, value, emptyValue: '-1');

    if (!isValid) return false;

    isValid = await controller.validate();

    if (!isValid && EHUtilHelper.isEmpty(controller.errorBucket![key]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }
}

class EHDropDownController extends EHEditWidgetController {
  late Map<String, String> items;

  RxString _selectedValue = ''.obs;

  RxBool focused = false.obs;

  get selectedValue {
    return _selectedValue.value;
  }

  set selectedValue(v) {
    _selectedValue.value = v;
  }

  ValueChanged<String>? onChanged;

  EHDropDownController({
    double? width,
    FocusNode? focusNode,
    String label = '',
    String selectedValue = '',
    bool enabled = true,
    bool mustInput = false,
    this.onChanged,
    Future<bool> Function()? validate,
    Map<Key?, String>? errorBucket,
    required Map<String, String> items,
  }) : super(
            validate: validate,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    this.autoFocus = autoFocus;
    this.label = label;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.items = items;
    this.selectedValue = selectedValue;
  }
}
