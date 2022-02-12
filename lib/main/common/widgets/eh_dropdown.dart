import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditPanelController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/responsive.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_error_info.dart';
import 'package:eh_flutter_framework/main/common/widgets/common/eh_edit_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHDropdown extends EHStatelessWidget<EHDropDownController> {
  EHDropdown(
      {Key? key,
      String label = '',
      String selectedValue = ' ',
      Map<String, String>? items,
      Map? errorBucket,
      bool enabled = true,
      bool mustInput = false,
      this.width = 200,
      ValueChanged<String>? onChanged,
      EHDropDownController? controller})
      : super(
            key: key,
            controller: controller ??
                EHDropDownController(
                    label: label,
                    selectedValue: selectedValue,
                    items: items ?? {},
                    errorBucket: errorBucket,
                    onChanged: onChanged,
                    enabled: enabled,
                    mustInput: mustInput));

  final double width;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];

    if (!items.contains('-1')) items.insert(0, '-1');

    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 5),
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
    if (controller.errorBucket == null)
      controller.errorBucket = EHEditPanelController.globalErrorBucket;

    return Obx(() => Container(
        padding: Responsive.isDesktop(context)
            ? EdgeInsets.symmetric(horizontal: 5)
            : EdgeInsets.symmetric(horizontal: 2),
        // height: 70,
        width: this.width,
        child: Column(
          children: [
            EHEditLabel(
              mustInput: controller.mustInput,
              label: controller.label,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .enabledBorder!
                        .borderSide
                        .color,
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'Select Item123213',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: _addDividersAfterItems(controller.items.keys.toList()),
                  customItemsIndexes: _getDividersIndexes(),
                  customItemsHeight: 4,
                  value: controller.items
                          .containsKey(controller._selectedValue.value)
                      ? controller._selectedValue.value
                      : '-1',
                  onChanged: controller._enabled.value
                      ? (v) {
                          if (controller.mustInput) {
                            if (v == "-1") {
                              controller.errorBucket![key] =
                                  'This field cannot be empty'.tr;
                            } else {
                              controller.errorBucket![key] = '';
                            }
                          }
                          controller.onChanged!(v.toString());
                        }
                      : null,
                  buttonHeight: 23.4,
                  buttonWidth: width,
                  itemHeight: 23,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                ),
              ),
            ),
            EHEditErrorInfo(
                errorBucket: this.controller.errorBucket!, errorFieldKey: key)
          ],
        )));
  }
}

class EHDropDownController extends EHController {
  GlobalKey<State<Tooltip>> tooltipKey = GlobalKey();

  late Map<String, String> items;

  RxBool _mustInput = false.obs;

  Map? errorBucket;

  RxString _selectedValue = ''.obs;

  get selectedValue {
    return _selectedValue.value;
  }

  set selectedValue(v) {
    _selectedValue.value = v;
  }

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

  ValueChanged<String>? onChanged;

  EHDropDownController(
      {String label = '',
      String selectedValue = '',
      bool enabled = true,
      bool mustInput = false,
      this.onChanged,
      Map? errorBucket,
      required Map<String, String> items}) {
    this.items = items;
    this.selectedValue = selectedValue;
    this.enabled = enabled;
    this.mustInput = mustInput;
    this.errorBucket = errorBucket;
  }
}
