import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditableWidget.dart';
import 'package:eh_flutter_framework/main/common/base/EHModel.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHDialog.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/EHRefactorHelper.dart';
import 'eh_text_field.dart';

import 'package:intl/intl.dart';

class EHDatePicker extends EHEditableWidget<EHDatePickerController> {
  EHDatePicker({
    required EHDatePickerController controller,
  }) : super(key: GlobalKey(), controller: controller);

  @override
  Widget build(BuildContext context) {
    if (controller.errorBucket == null)
      controller.errorBucket = EHController.globalErrorBucket;

    return EHTextField(controller: controller._textEditingController);
  }
}

class EHDatePickerController extends EHEditableWidgetController {
  late EHTextFieldController _textEditingController;

  EHTextFieldController get innerTextEditingController {
    return _textEditingController;
  }

  late String _dateFormat;
  RxBool is24HoursMode = true.obs;
  bool showTimePicker;

  set textFieldKey(val) {
    this._textEditingController.key = val;
  }

  Key? get textFieldKey {
    return this._textEditingController.key;
  }

  late DateTime? _bindingValue;

  String getDisplayValue() {
    DateTime? value;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      value = EHRefactorHelper.getFieldValue(model!, bindingFieldName!)
          as DateTime?;
    } else {
      value = _bindingValue;
    }

    String displayValue;
    if (key != null && EHController.globalDisplayValueBucket[key] != null) {
      displayValue = EHController.globalDisplayValueBucket[key]!;
    } else {
      displayValue = getBindingStringValue(value);
    }

    return displayValue;
  }

  EHDatePickerController(
      {Key? key,
      List<Object?>? dependentObxValues,
      EHModel? model,
      String? bindingFieldName,
      double? width,
      bool autoFocus = false,
      FocusNode? focusNode,
      String label = '',
      DateTime? bindingValue,
      bool enabled = true,
      bool mustInput = false,
      this.showTimePicker = false,
      String? dateFormat,
      ValueChanged<DateTime?>? onChanged,
      Future<bool> Function()? validate,
      Map<Key?, String>? errorBucket})
      : super(
            model: model,
            bindingFieldName: bindingFieldName,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            validate: validate,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: FocusNode(),
            errorBucket: errorBucket) {
    this._dateFormat = dateFormat == null
        ? !this.showTimePicker
            ? 'yyyy/MM/dd'
            : 'yyyy/MM/dd HH:mm:ss'
        : dateFormat;

    _bindingValue = bindingValue;

    this._textEditingController = EHTextFieldController(
        key: key,
        focusNode: focusNode,
        label: label,
        bindingValue: getDisplayValue(),
        textHint: this._dateFormat,
        enabled: enabled,
        mustInput: mustInput,
        validate: () async {
          //Call by TextField to prevent focus change.
          return await _validate();
        },
        onChanged: (text) {
          try {
            DateTime? parsedDate = bindingValue;
            if (!EHUtilHelper.isEmpty(_textEditingController.displayValue)) {
              try {
                parsedDate = new DateFormat(_dateFormat).parseStrict(text);
              } catch (e) {
                parsedDate = null;
              }
            } else {
              parsedDate = null;
            }
            EHController.globalDisplayValueBucket.remove(textFieldKey!);
            setModelValue(parsedDate);

            focusNode!.requestFocus();
            focusNode.nextFocus();

            if (onChanged != null) onChanged(parsedDate);
          } catch (e) {
            return;
          }
        },
        afterWidget: ExcludeFocus(
            child: SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.event_note),
              onPressed: enabled
                  ? () async {
                      EHDialog.showPopupDialog(
                          Card(
                            child: SfDateRangePicker(
                              showActionButtons: true,
                              confirmText: 'Confirm'.tr,
                              cancelText: 'Cancel'.tr,
                              toggleDaySelection: true,
                              headerStyle: DateRangePickerHeaderStyle(
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                    // fontSize: 18,
                                    color: Get.textTheme.bodyText1!.color,
                                  )),
                              showNavigationArrow: true,
                              //   showTodayButton: true,
                              initialSelectedDate: getDisplayDate(),
                              initialDisplayDate: getDisplayDate(),
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs
                                      args) async {
                                //selection change ==null means deselect date, return directly and waiting for select date again
                                if (args.value == null) return;
                                DateTime? selectedDateTime = await addTime2Date(
                                    args.value as DateTime?, bindingValue);

                                if (selectedDateTime != null) {
                                  EHController.globalDisplayValueBucket
                                      .remove(textFieldKey!);
                                  this._textEditingController.displayValue =
                                      getBindingStringValue(selectedDateTime);
                                  setModelValue(selectedDateTime);

                                  this
                                      ._textEditingController
                                      .focusNode!
                                      .requestFocus();
                                  this
                                      ._textEditingController
                                      .focusNode!
                                      .nextFocus();

                                  if (onChanged != null) {
                                    onChanged(selectedDateTime);
                                  }
                                }
                              },
                              onSubmit: (value) async {
                                DateTime? selectedDateTime = await addTime2Date(
                                    value as DateTime?, value);

                                if (selectedDateTime != null) {
                                  EHController.globalDisplayValueBucket
                                      .remove(textFieldKey!);
                                  setModelValue(selectedDateTime);

                                  this
                                      ._textEditingController
                                      .focusNode!
                                      .requestFocus();
                                  this
                                      ._textEditingController
                                      .focusNode!
                                      .nextFocus();

                                  if (onChanged != null) {
                                    onChanged(selectedDateTime);
                                  }
                                }
                              },
                              onCancel: () {
                                Get.back();
                              },
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                            ),
                            elevation: 10,
                          ),
                          height: 400,
                          width: 400,
                          title: 'Please Select Date'.tr);
                    }
                  : null),
        )));
  }

  @override
  init() {
    _textEditingController.displayValue = getDisplayValue();
    this.textFieldKey = key;
    this._textEditingController.focusNode = focusNode;
  }

  getBindingStringValue(DateTime? bindingValue) {
    return bindingValue == null
        ? ''
        : DateFormat(_dateFormat).format(bindingValue);
  }

  Future<DateTime?> addTime2Date(
      DateTime? selectedDate, DateTime? originalDateTime) async {
    TimeOfDay? time;

    if (selectedDate == null) {
      EHToastMessageHelper.showInfoMessage('Please select a date firstly'.tr);
      return null;
    }

    if (showTimePicker) {
      time = await showCustomTimePicker(
          TimeOfDay.fromDateTime(originalDateTime ?? DateTime.now()));
      if (time == null) {
        Get.back();
        return null;
      } else {
        Get.back();
        errorBucket![textFieldKey!] = '';
        return new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, time.hour, time.minute);
      }
    } else {
      Get.back();
      errorBucket![textFieldKey!] = '';
      return selectedDate;
    }
  }

  Future<TimeOfDay?> showCustomTimePicker(TimeOfDay? initTime) async {
    Widget dialog = Obx(() => SimpleDialog(
            contentPadding: EdgeInsets.all(5),
            titlePadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            children: [
              MediaQuery(
                  data: MediaQuery.of(Get.context!)
                      .copyWith(alwaysUse24HourFormat: is24HoursMode.value),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Use 24 hours'.tr),
                              SizedBox(
                                width: 20,
                              ),
                              FlutterSwitch(
                                width: 55,
                                height: 30,
                                activeTextColor: Colors.green,
                                inactiveTextColor: Colors.grey,
                                value: is24HoursMode.value,
                                onToggle: (val) {
                                  is24HoursMode.value = val;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      TimePickerDialog(
                        initialTime: initTime ?? TimeOfDay.now(),
                        // initialEntryMode: initialEntryMode,
                      ),
                    ],
                  )),
            ]));
    TimeOfDay? time = await showDialog<TimeOfDay>(
        context: Get.context!,
        builder: (context) {
          return dialog;
        });
    return time;
  }

  getDisplayDate() {
    DateTime? date;
    try {
      date = new DateFormat(_dateFormat)
          .parseStrict(_textEditingController.displayValue);
    } catch (e) {
      //print(e);
    }

    return date;
  }

  Future<bool> _validate() async {
    bool isValid = checkMustInput(
        textFieldKey!, _textEditingController.displayValue,
        emptyValue: '');

    if (!isValid) return false;

    try {
      if (!EHUtilHelper.isEmpty(_textEditingController.displayValue))
        new DateFormat(_dateFormat)
            .parseStrict(_textEditingController.displayValue);
    } catch (e) {
      errorBucket![textFieldKey!] = 'Date format should be: '.tr + _dateFormat;
      return false;
    }

    isValid = await validate();

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![textFieldKey!]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }

  @override
  Future<bool> validateWidget() async {
    return _validate();
  }
}
