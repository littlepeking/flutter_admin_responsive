import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_check_box.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_custom_form_widget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wms_module/components/receipt/models/receipt_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wms_module/components/receipt/receipt_edit_controller.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../common/base/eh_controller.dart';
import '../../../../../../../../common/widgets/eh_form_divider.dart';
import '../../../../../../../../common/widgets/eh_multi_select.dart';
import '../../../../../../../../common/widgets/eh_datagrid/eh_datagrid_source.dart';
import '../../../../../../../../common/widgets/eh_dropdown.dart';

class ReceiptDetailViewController extends EHPanelController {
  RxString ddlType = '0'.obs;

  Key testKey = GlobalKey(debugLabel: 'deef');

  Rxn<MapEntry<String, String>> gridDynamicFilter = Rxn(MapEntry('city', ''));

  Rx<ReceiptModel> receiptModel = ReceiptModel(
          receiptKey: 'r1',
          num1: 1,
          num2: 2.50,
          customerId: 'cus001',
          customerName: 'cus001Name',
          dropdownValue: '1',
          dropdownValue2: '0',
          dropdownValue3: '0',
          multiSelectValues: ['1', '2'],
          dateTime: DateTime.now(),
          dateTime2: EHUtilHelper.getGMT11AMOfToday())
      .obs;

  late Function datePicker1ControllerFunc;
  ReceiptDetailViewController(EHPanelController parent) : super(parent) {
    datePicker1ControllerFunc = () {
      return EHDatePickerController(
          key: datePicker1,
          dependentObxValues: [receiptModel.value],
          mustInput: true,
          //enabled: false,
          focusNode: datePickerFn1,
          bindingValue: receiptModel.value.dateTime,
          onEditingComplete: (value) => receiptModel.update((model) {
                model!.dateTime = value;
              }),
          label: 'common.general.Date');
    };

    EHDataGridSource popUpDataSource = DataGridTest.getDataGridSource();
    //EHDataGridSource popUpDataSource = DataGridTest.getCommonDataGridSource();

    widgetBuilderFormController = EHEditFormController(widgetBuilders: [
      (key, focusNode) => EHTextField(
            // autoFocus: true,
            controller: EHTextFieldController(
                key: key,
                focusNode: focusNode,
                //autoFocus: true,
                label: '测试1',
                bindingValue: receiptModel.value.receiptKey ?? '',
                mustInput: true,
                onEditingComplete: (value) => receiptModel.update((model) {
                      model!.receiptKey = value;
                    })),
          ),
      (key, focusNode) => EHPopup(
            controller: EHPopupController(
                key: key,
                popupTitle: 'Please Select Supplier',
                focusNode: focusNode,
                codeColumnName: 'receiptKey',
                dataSource: DataGridTest.getDataGridSource(),
                label: 'popUp',
                bindingValue: receiptModel.value.receiptKey,
                mustInput: true,
                //  autoFocus: true,
                onEditingComplete: (code, row) {
                  //  controller.popUpFn!.requestFocus();
                  receiptModel.update((model) {
                    model!.receiptKey = code;
                    model.customerName = row?['name'] ?? '';
                  });
                }),
          ),
      (key, focusNode) => EHDatePicker(
          controller: EHDatePickerController(
              key: key,
              mustInput: true,
              //enabled: false,
              focusNode: focusNode,
              bindingValue: receiptModel.value.dateTime,
              onEditingComplete: (value) => receiptModel.update((model) {
                    model!.dateTime = value;
                  }),
              label: 'common.general.Date')),
    ]);

    getWidgetControllerFormController = () =>
        widgetControllerFormController = EHEditFormController<ReceiptModel>(
            widgetFocusNodes: widgetControllerFormController?.widgetFocusNodes,
            widgetKeys: widgetControllerFormController?.widgetKeys,
            dependentObxValues: [ddlType.value, gridDynamicFilter.value],
            rxModel: receiptModel,
            widgetControllerBuilders: [
              () => EHTextFieldController(
                  label: '文本框',
                  //autoFocus: true,
                  bindingFieldName: 'receiptKey',
                  mustInput: true,
                  onChanged: (v) => {
                        print(v)
                      }, // onChanged 仅在需要输入字母时马上触发控件时才使用，避免不必要的性能损耗，一般功能请使用onEditingComplete。
                  onEditingComplete: (value) {}),
              () => EHDropDownController(
                  label: '下拉框',
                  mustInput: true,
                  bindingFieldName: 'dropdownValue',
                  items: {
                    '0': 'Item0',
                    '1': 'Item1',
                    '2': 'Item2',
                  },
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: '整数',
                  type: EHTextInputType.Int,
                  //autoFocus: true,
                  bindingFieldName: 'num1',
                  //   mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: '浮点数',
                  type: EHTextInputType.Double,
                  //autoFocus: true,
                  bindingFieldName: 'num2',
                  mustInput: true,
                  onEditingComplete: (value) {
                    print('text = onChange triggered');
                  }),
              () => EHDropDownController(
                  label: '下拉框1-级联',
                  bindingFieldName: 'dropdownValue',
                  items: {
                    '0': 'Item0',
                    '1': 'Item1',
                    '2': 'Item2',
                  },
                  onChanged: (value) {
                    ddlType.value = value;
                    //use parent controller to do something...
                    EHToastMessageHelper.showInfoMessage(
                        (rootController as ReceiptEditController)
                            .asnHeaderDataGridController
                            .dataGridSource
                            .getSelectedRows()
                            .map((e) {
                              // print(e);
                              return e['id'];
                            })
                            .join(',')
                            .toString());
                  }),
              () => EHDropDownController(
                  label: '下拉框2',
                  bindingFieldName: 'dropdownValue2',
                  items: getDDLItems(ddlType.value),
                  onChanged: (value) => {}),
              () => EHDropDownController(
                  label: '下拉框3',
                  bindingFieldName: 'dropdownValue3',
                  items: () {
                    receiptModel.value.dropdownValue3 =
                        receiptModel.value.dropdownValue;
                    //get items data based on other widget value
                    return getDDLItems(receiptModel.value.dropdownValue);
                  }(),
                  onChanged: (value) => {}),
              () => EHDropDownController(
                  label: '下拉框-级联',
                  bindingFieldName: 'dropdownValue',
                  items: {
                    'city:PEK': 'city:Beijing',
                    'enabled:true': 'enabled:Y',
                  },
                  onChanged: (value) {
                    if (value == '') {
                      popUpDataSource.setFilter('city', '');
                      popUpDataSource.setFilter('enabled', '');
                      // gridDynamicFilter.value = null;
                    } else {
                      popUpDataSource.setFilter('city', '');
                      popUpDataSource.setFilter('enabled', '');
                      List<String> values = value.split(':');
                      popUpDataSource.setFilter(values[0], values[1]);

                      //gridDynamicFilter.value = MapEntry(values[0], values[1]);
                    }
                    //gridDynamicFilter.refresh();
                  }),
              () => EHPopupController(
                  label: 'popUp',
                  bindingFieldName: 'receiptKey',
                  popupTitle: 'Please Select Supplier',
                  codeColumnName: 'receiptKey',
                  dataSource: popUpDataSource,
                  mustInput: true,
                  onEditingComplete: (code, row) {
                    print('pop = onChange triggered');
                    if (row != null)
                      receiptModel.value.receiptKey =
                          row['receiptKey'].toString();
                    //no need manual refresh when update current form's data model as it already triggered by EHEditForm.
                    // receiptModel.refresh();
                  }),
              () => EHMultiSelectController(
                  bindingFieldName: 'multiSelectValues',
                  label: '多选框',
                  mustInput: true,
                  items: {
                    '0': 'MItem0',
                    '1': 'MItem1',
                    '2': 'MItem2',
                  },
                  onChanged: (value) => {}),
              () => EHDatePickerController(
                    label: 'common.general.Date',
                    bindingFieldName: 'dateTime',
                    mustInput: true,
                    onEditingComplete: (value) => {},
                    onValidate: (controller) async {
                      var c = controller as EHDatePickerController;
                      print(c.parsedDate);
                      bool isAfterToday = c.parsedDate!.isAfter(DateTime.now());
                      if (!isAfterToday) {
                        EHController.setWidgetError(
                            EHController.globalErrorBucket,
                            controller.textFieldKey!,
                            'Date must more than today');
                      }
                      return isAfterToday;
                    },
                  ),
              () => EHDatePickerController(
                    enabled: false,
                    label: 'common.general.Date',
                    bindingFieldName: 'dateTime',
                    mustInput: true,
                    onEditingComplete: (value) => {},
                  ),
              () => EHDatePickerController(
                    label: 'common.general.time',
                    bindingFieldName: 'dateTime2',
                    mustInput: true,
                    showTimePicker: true,
                    onEditingComplete: (value) =>
                        {print('datepicker = onChange triggered')},
                  ),
              () => EHDatePickerController(
                    enabled: false,
                    label: 'common.general.time',
                    bindingFieldName: 'dateTime2',
                    mustInput: true,
                    showTimePicker: true,
                    onEditingComplete: (value) => {},
                  ),
              () => EHCheckBoxController(
                  label: 'checkBox',
                  bindingFieldName: 'isChecked',
                  onChanged: (v) {
                    widgetControllerFormController!.widgetFocusNodes![0]
                        .requestFocus();
                  }),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  label: '文本框',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'receiptKey',
                  mustInput: true,
                  maxLines: 3,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: '文本框',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'receiptKey',
                  mustInput: true,
                  maxLines: 3,
                  onEditingComplete: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHCustomFormWidgetController<ReceiptModel>(
                    widgetBuilder: (key, focusNode, rxModel) =>
                        CustomWidget(key, focusNode, rxModel),
                  ),
              () => EHCustomFormWidgetController<ReceiptModel>(
                    widgetBuilder: (key, focusNode, rxModel) {
                      return Container(
                          margin: EdgeInsets.only(left: 100),
                          color: Colors.yellow,
                          width: 200,
                          child: Obx(() => Center(
                                child: Text(
                                  'Custom widget example2:' +
                                      (rxModel!.value.receiptKey ?? ''),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.red),
                                ),
                              )));
                    },
                  ),
              () => EHFormDividerController(width: 1),
            ]);
  }

  // ignore: avoid_init_to_null
  late EHEditFormController? widgetControllerFormController = null;

  Function? getWidgetControllerFormController;

  FocusNode popUpFn = FocusNode();
  FocusNode textFn1 = FocusNode(
      //   onKeyEvent: (n, event) {
      //   if (event.logicalKey == LogicalKeyboardKey.tab) {
      //     // Do something
      //     if (n.context!.widget is EditableText) {
      //       (n.context!.widget as EditableText).onEditingComplete!();
      //     }
      //     return KeyEventResult.handled;
      //   } else {
      //     return KeyEventResult.ignored;
      //   }
      // }
      );
  FocusNode textFn2 = FocusNode();
  FocusNode ddlFn1 = FocusNode();
  FocusNode ddlFn2 = FocusNode();
  FocusNode multiSelectFn1 = FocusNode();

  FocusNode datePickerFn1 = FocusNode();

  FocusNode datePickerFn2 = FocusNode();
  FocusNode checkBoxFn1 = FocusNode();

  GlobalKey popupKey1 = GlobalKey();
  GlobalKey textKey1 = GlobalKey();
  GlobalKey textKey2 = GlobalKey();
  GlobalKey dropdownKey1 = GlobalKey();
  GlobalKey dropdownKey2 = GlobalKey();

  GlobalKey multiSelectKey1 = GlobalKey();

  GlobalKey datePicker1 = GlobalKey();

  GlobalKey datePicker2 = GlobalKey();

  GlobalKey checkBoxKey1 = GlobalKey();

  late EHEditFormController widgetBuilderFormController;

  static getDDLItems(String type) {
    if (type == "0") {
      return {
        '0': 'Item0',
      };
    } else if (type == "1") {
      return {
        '1': 'Item1',
      };
    } else {
      return {
        '2': 'Item4',
      };
    }
  }
}

class CustomWidget extends EHValidationWidget {
  CustomWidget(this.key, this.focusNode, this.rxModel);

  final FocusNode? focusNode;
  final Key? key;
  final Rx<ReceiptModel?>? rxModel;

  @override
  Future<bool> validate() async {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        margin: EdgeInsets.only(left: 100),
        child: Text(
            'Custom widget example1:' + (rxModel!.value?.receiptKey ?? ''))));
  }
}
