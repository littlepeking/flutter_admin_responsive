import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/constants/layout_constant.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_dialog.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../utils/eh_refactor_helper.dart';
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

  late DateTime? parsedDate;

  bool goNextAfterComplete;

  String getDisplayValue() {
    DateTime? value = getInitValue();

    String displayValue;
    //if exists Widget Error means displayValue should be used even it is empty. e.g.must input error
    if (key != null &&
        (!EHUtilHelper.isEmpty(EHController.getWidgetDisplayValue(key!)) ||
            !EHUtilHelper.isEmpty(
                EHController.getWidgetError(errorBucket!, key!)))) {
      displayValue = EHController.getWidgetDisplayValue(key!);
    } else {
      displayValue = getBindingStringValue(value);
    }

    return displayValue;
  }

  DateTime? getInitValue() {
    DateTime? value;

    //Check if exists ehEditForm first
    if (model != null && bindingFieldName != null) {
      value = EHRefactorHelper.getFieldValue(model!, bindingFieldName!)
          as DateTime?;
    } else {
      value = _bindingValue;
    }
    return value;
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
      EHEditableWidgetOnValidate? onValidate,
      Map<Key?, RxString>? errorBucket,
      bool showErrorInfo = true,
      bool showLabel = true,
      this.goNextAfterComplete = true})
      : super(
            key: key,
            model: model,
            bindingFieldName: bindingFieldName,
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            onValidate: onValidate,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: FocusNode(),
            errorBucket: errorBucket) {
    this._dateFormat = dateFormat == null
        ? !this.showTimePicker
            ? 'yyyy/MM/dd'
            : 'yyyy/MM/dd HH:mm:ss'
        : dateFormat;

    _bindingValue = bindingValue;

    validateAndUpdateDate(DateTime selectedDate) async {
      DateTime? selectedDateTime =
          await addTime2Date(selectedDate, getInitValue());

      if (selectedDateTime != null) {
        EHController.setWidgetDisplayValue(
            textFieldKey!, getBindingStringValue(selectedDateTime));

        parsedDate = selectedDateTime;

        if (await userValidate()) {
          EHController.setWidgetDisplayValue(textFieldKey!, '');
          // this._textEditingController.displayValue =
          //     getBindingStringValue(selectedDateTime);
          if (!EHUtilHelper.dateEquals(getInitValue(), selectedDateTime)) {
            setModelValue(selectedDateTime);
            if (onChanged != null) {
              onChanged(selectedDateTime);
            }
          }

          this._textEditingController.focusNode!.requestFocus();
          this._textEditingController.focusNode!.nextFocus();
        } else {
          this._textEditingController.focusNode!.requestFocus();
        }
      } else {
        this._textEditingController.focusNode!.requestFocus();
      }
    }

    this._textEditingController = EHTextFieldController(
        key: key,
        focusNode: focusNode,
        label: label,
        bindingValue: getDisplayValue(),
        textHint: this._dateFormat,
        enabled: enabled,
        mustInput: mustInput,
        showLabel: showLabel,
        showErrorInfo: showErrorInfo,
        goNextAfterComplete: goNextAfterComplete,
        onValidate: (controller) async {
          //Call by TextField to prevent focus change.
          return await _validate();
        },
        onChanged: (text) {
          //EHController.globalDisplayValueBucket.remove(textFieldKey!);

          if (!EHUtilHelper.dateEquals(getInitValue(), parsedDate)) {
            setModelValue(parsedDate);
            if (onChanged != null) onChanged(parsedDate);
          }

          // focusNode!.requestFocus();
          // focusNode.nextFocus();
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

                                validateAndUpdateDate(args.value as DateTime);
                              },
                              onSubmit: (value) async {
                                validateAndUpdateDate(value as DateTime);
                              },
                              onCancel: () {
                                this
                                    ._textEditingController
                                    .focusNode!
                                    .requestFocus();
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
        EHController.setWidgetError(errorBucket!, textFieldKey!, '');
        return new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, time.hour, time.minute);
      }
    } else {
      Get.back();
      EHController.setWidgetError(errorBucket!, textFieldKey!, '');
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
    EHController.setWidgetDisplayValue(
        textFieldKey!, _textEditingController.displayValue);
    EHController.setWidgetError(errorBucket!, textFieldKey!, '');
    bool isValid = checkMustInput(
        textFieldKey!, _textEditingController.displayValue,
        emptyValue: '');

    if (!isValid)
      return false;
    //when date is empty, set value to null
    else if (EHUtilHelper.isEmpty(_textEditingController.displayValue)) {
      parsedDate = null;
      EHController.setWidgetDisplayValue(textFieldKey!, '');
      return true;
    } else {
      //check if date is match format
      try {
        parsedDate = new DateFormat(_dateFormat)
            .parseStrict(_textEditingController.displayValue);
      } catch (e) {
        EHController.setWidgetDisplayValue(
            textFieldKey!, _textEditingController.displayValue);
        EHController.setWidgetError(errorBucket!, textFieldKey!,
            'Date format should be: '.tr + _dateFormat);

        return false;
      }

      isValid = await userValidate();

      if (isValid) {
        EHController.setWidgetDisplayValue(textFieldKey!, '');
      }
      return isValid;
    }
  }

  Future<bool> userValidate() async {
    bool isValid = await onValidate(this);

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
