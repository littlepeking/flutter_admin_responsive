import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/constants/layoutConstant.dart';
import 'package:eh_flutter_framework/main/common/utils/EHDialog.dart';
import 'package:eh_flutter_framework/main/common/utils/EHUtilHelper.dart';
import 'package:flutter/material.dart';
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
  String dateFormat;

  EHDatePickerController(
      {double? width,
      bool autoFocus = false,
      required FocusNode focusNode,
      String label = '',
      DateTime? initDateTime,
      bool enabled = true,
      bool mustInput = false,
      this.dateFormat = 'yyyy/MM/dd',
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
    this._textEditingController = EHTextFieldController(
        focusNode: focusNode,
        label: label,
        text: initDateTime == null
            ? ''
            : DateFormat(dateFormat).format(initDateTime),
        textHint: dateFormat,
        enabled: enabled,
        mustInput: mustInput,
        validate: () async {
          return await _validate();
        },
        onChanged: (value) async {
          DateTime parsedDate = new DateFormat(dateFormat).parseStrict(value);
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
                          SfDateRangePicker(
                            headerStyle: DateRangePickerHeaderStyle(
                                textAlign: TextAlign.center,
                                textStyle: TextStyle(
                                  // fontSize: 18,
                                  color: Get.textTheme.bodyText1!.color,
                                )),
                            showNavigationArrow: true,
                            showActionButtons: false,
                            //   showTodayButton: true,
                            initialSelectedDate: getDisplayDate(),
                            initialDisplayDate: getDisplayDate(),
                            onSelectionChanged:
                                (DateRangePickerSelectionChangedArgs args) {
                              _textEditingController.text =
                                  DateFormat(dateFormat).format(args.value);
                              if (onChanged != null) onChanged(args.value);
                              Get.back();
                            },
                            selectionMode: DateRangePickerSelectionMode.single,
                          ),
                          height: 400,
                          width: 400,
                          title: 'Please Select Date'.tr);
                    }
                  : null),
        )));
  }

  getDisplayDate() {
    DateTime date = DateTime.now();
    try {
      date =
          new DateFormat(dateFormat).parseStrict(_textEditingController.text);
    } catch (e) {
      print(e);
    }

    return date;
  }

  Future<bool> _validate() async {
    bool isValid = checkMustInput(textFieldKey, _textEditingController.text,
        emptyValue: '');

    if (!isValid) return false;

    try {
      new DateFormat(dateFormat).parseStrict(_textEditingController.text);
    } catch (e) {
      errorBucket![textFieldKey] = 'Date format should be: '.tr + dateFormat;
      return false;
    }

    isValid = await validate();

    if (!isValid && EHUtilHelper.isEmpty(errorBucket![textFieldKey]))
      throw Exception(
          'Error: Must provide error message in errorBucket while validate failed');

    return isValid;
  }
}
