import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHDialog.dart';
import 'package:eh_flutter_framework/main/common/utils/EHToastMsgHelper.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'eh_text_field.dart';

import 'package:intl/intl.dart';

class EHDatePicker extends EHStatelessWidget<EHDatePickerController> {
  EHDatePicker({
    required Key key,
    required EHDatePickerController controller,
  })  : this.textFieldKey = key,
        super(
            key: GlobalKey(debugLabel: key.toString()), controller: controller);

  late final textFieldKey;

  @override
  Widget build(BuildContext context) {
    if (controller.errorBucket == null)
      controller.errorBucket = EHController.globalErrorBucket;
    controller.textFieldKey = this.textFieldKey!;

    return EHTextField(
        key: textFieldKey!, //GET RELATED KEY USING DEBUGLABEL AS WORKAROUND
        controller: controller._textEditingController);
  }
}

class EHDatePickerController extends EHEditWidgetController {
  late EHTextFieldController _textEditingController;

  late Key textFieldKey;
  late String _dateFormat;
  RxBool is24HoursMode = true.obs;
  bool showTimePicker;

  EHDatePickerController(
      {double? width,
      bool autoFocus = false,
      required FocusNode focusNode,
      String label = '',
      DateTime? dateTime,
      bool enabled = true,
      bool mustInput = false,
      this.showTimePicker = false,
      String? dateFormat,
      ValueChanged<DateTime>? onChanged,
      Future<bool> Function()? validate,
      Map<Key?, String>? errorBucket})
      : super(
            autoFocus: autoFocus,
            enabled: enabled,
            mustInput: mustInput,
            label: label,
            validate: validate,
            width: width ?? LayoutConstant.editWidgetSize,
            focusNode: focusNode,
            errorBucket: errorBucket) {
    this._dateFormat = dateFormat == null
        ? !this.showTimePicker
            ? 'yyyy/MM/dd'
            : 'yyyy/MM/dd HH:mm:ss'
        : dateFormat;

    this._textEditingController = EHTextFieldController(
        focusNode: focusNode,
        label: label,
        text: dateTime == null ? '' : DateFormat(_dateFormat).format(dateTime),
        textHint: this._dateFormat,
        enabled: enabled,
        mustInput: mustInput,
        validate: () async {
          return await _validate();
        },
        onChanged: (value) async {
          DateTime parsedDate = new DateFormat(_dateFormat).parseStrict(value);
          if (onChanged != null) onChanged(parsedDate);
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
                                    args.value as DateTime?, dateTime);
                                if (selectedDateTime != null &&
                                    onChanged != null)
                                  onChanged(selectedDateTime);
                              },
                              onSubmit: (value) async {
                                DateTime? selectedDateTime = await addTime2Date(
                                    value as DateTime?, dateTime);
                                if (selectedDateTime != null &&
                                    onChanged != null)
                                  onChanged(selectedDateTime);
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
        return new DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, time.hour, time.minute);
      }
    } else {
      Get.back();
      return selectedDate;
    }
  }

  Future<TimeOfDay?> showCustomTimePicker(TimeOfDay? initTime) async {
    Widget dialog = Obx(() => SimpleDialog(children: [
          MediaQuery(
              data: MediaQuery.of(Get.context!).copyWith(
                  textScaleFactor: 1.2,
                  alwaysUse24HourFormat: is24HoursMode.value),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
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
                    height: 5,
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
      date =
          new DateFormat(_dateFormat).parseStrict(_textEditingController.text);
    } catch (e) {
      //print(e);
    }

    return date;
  }

  Future<bool> _validate() async {
    bool isValid = checkMustInput(textFieldKey, _textEditingController.text,
        emptyValue: '');

    if (!isValid) return false;

    try {
      new DateFormat(_dateFormat).parseStrict(_textEditingController.text);
    } catch (e) {
      errorBucket![textFieldKey] = 'Date format should be: '.tr + _dateFormat;
      return false;
    }

    isValid = await validate();

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![textFieldKey]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }
}
