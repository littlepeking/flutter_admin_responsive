import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_check_box.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_custom_form_widget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/receipt_edit_controller.dart';
import 'package:eh_flutter_framework/test/TestData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../../../../../common/widgets/eh_form_divider.dart';
import '../../../../../../../../common/widgets/eh_multi_select.dart';
import '../../../../../../../../common/widgets/eh_datagrid/eh_datagrid_source.dart';
import '../../../../../../../../common/widgets/eh_dropdown.dart';

class ReceiptDetailViewController extends EHPanelController {
  RxString ddlType = '0'.obs;

  Rxn<MapEntry<String, String>> gridDynamicFilter = Rxn(MapEntry('city', ''));

  Rx<ReceiptModel> receiptModel = ReceiptModel(
          receiptKey: 'key001',
          num1: 1,
          num2: 2.50,
          customerId: 'cus001',
          customerName: 'cus001Name',
          dropdownValue: '1',
          dropdownValue2: '0',
          multiSelectValues: ['1', '2'],
          dateTime: DateTime.now(),
          dateTime2: DateTime.now())
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
          onChanged: (value) => receiptModel.update((model) {
                model!.dateTime = value;
              }),
          label: 'date');
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
                bindingValue: receiptModel.value.receiptKey,
                mustInput: true,
                onChanged: (value) => receiptModel.update((model) {
                      model!.receiptKey = value;
                    })),
          ),
      (key, focusNode) => EHPopup(
            controller: EHPopupController(
                key: key,
                popupTitle: 'Please Select Supplier',
                focusNode: focusNode,
                codeColumnName: 'customerId',
                dataSource: DataGridTest.getDataGridSource(),
                label: 'popUp',
                bindingValue: receiptModel.value.customerId,
                mustInput: true,
                //  autoFocus: true,
                onChanged: (code, row) {
                  //  controller.popUpFn!.requestFocus();
                  receiptModel.update((model) {
                    model!.customerId = code;
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
              onChanged: (value) => receiptModel.update((model) {
                    model!.dateTime = value;
                  }),
              label: 'date')),
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
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: '整数',
                  type: EHTextInputType.Int,
                  //autoFocus: true,
                  bindingFieldName: 'num1',
                  //   mustInput: true,
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: '浮点数',
                  type: EHTextInputType.Double,
                  //autoFocus: true,
                  bindingFieldName: 'num2',
                  mustInput: true,
                  onChanged: (value) {}),
              () => EHDropDownController(
                  label: '下拉框1-级联',
                  bindingFieldName: 'dropdownValue',
                  validate: () async => true,
                  items: {
                    '0': 'Item0',
                    '1': 'Item1',
                    '2': 'Item2',
                  },
                  onChanged: (value) {
                    ddlType.value = value;
                    //use parent controller to do something...
                    EHToastMessageHelper.showInfoMessage(
                        (root as ReceiptEditController)
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
                  validate: () async => true,
                  //items: getDDLItems(receiptModel.value.dropdownValue),
                  items: getDDLItems(ddlType.value),
                  onChanged: (value) => {}),
              () => EHDropDownController(
                  label: '下拉框-级联',
                  bindingFieldName: 'dropdownValue',
                  validate: () async => true,
                  items: {
                    'city:PEK': 'city:Beijing',
                    'isConfirmed:true': 'isConfirmed:Y',
                  },
                  onChanged: (value) {
                    if (value == '') {
                      popUpDataSource.setFilter('city', '');
                      popUpDataSource.setFilter('isConfirmed', '');
                      // gridDynamicFilter.value = null;
                    } else {
                      popUpDataSource.setFilter('city', '');
                      popUpDataSource.setFilter('isConfirmed', '');
                      List<String> values = value.split(':');
                      popUpDataSource.setFilter(values[0], values[1]);

                      //gridDynamicFilter.value = MapEntry(values[0], values[1]);
                    }
                    //gridDynamicFilter.refresh();
                  }),
              () => EHPopupController(
                  label: 'popUp',
                  bindingFieldName: 'customerId',
                  popupTitle: 'Please Select Supplier',
                  codeColumnName: 'id',
                  dataSource: popUpDataSource,
                  mustInput: true,
                  onChanged: (code, row) {
                    if (row != null)
                      receiptModel.value.receiptKey =
                          row['customerId'].toString();
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
                    label: 'date',
                    bindingFieldName: 'dateTime',
                    mustInput: true,
                    onChanged: (value) => {},
                  ),
              () => EHDatePickerController(
                    enabled: false,
                    label: 'date',
                    bindingFieldName: 'dateTime',
                    mustInput: true,
                    onChanged: (value) => {},
                  ),
              () => EHDatePickerController(
                    label: 'time',
                    bindingFieldName: 'dateTime2',
                    mustInput: true,
                    showTimePicker: true,
                    onChanged: (value) => {},
                  ),
              () => EHDatePickerController(
                    enabled: false,
                    label: 'time',
                    bindingFieldName: 'dateTime2',
                    mustInput: true,
                    showTimePicker: true,
                    onChanged: (value) => {},
                  ),
              () => EHCheckBoxController(
                  label: 'checkBox',
                  bindingFieldName: 'isChecked',
                  onChanged: (v) {
                    widgetControllerFormController!.widgetFocusNodes![0]
                        .requestFocus();
                  }),
              () => EHCustomFormWidgetController<ReceiptModel>(
                    widgetBuilder: (key, focusNode, rxModel) =>
                        CustomWidget(key, focusNode, rxModel),
                  ),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  label: '文本框',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'receiptKey',
                  mustInput: true,
                  maxLines: 3,
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: '文本框',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'receiptKey',
                  mustInput: true,
                  maxLines: 3,
                  onChanged: (value) {}),
              () => EHCustomFormWidgetController<ReceiptModel>(
                    widgetBuilder: (key, focusNode, rxModel) {
                      return Container(
                          color: Colors.yellow,
                          width: 200,
                          child: Obx(() => Center(
                                child: Text(
                                  rxModel!.value.receiptKey,
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

  FocusNode? focusNode;
  Key? key;
  Rx<ReceiptModel>? rxModel;

  @override
  bool validate() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Text(rxModel!.value.receiptKey));
  }
}
