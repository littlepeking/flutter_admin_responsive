/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'permission_model.dart';
import 'permission_tree_controller.dart';

class PermissionDetailViewController extends EHPanelController {
  //Here we need set controller to null expliciltly, otherwise DetailViewController constructor will cannot assign init value to getWidgetControllerFormController
  // ignore: avoid_init_to_null
  late EHEditFormController? detailViewFormController = null;

  Function? getWidgetControllerFormController;

  PermissionDetailViewController._create(EHPanelController parent)
      : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<PermissionDetailViewController> create(
      EHPanelController parent) async {
    PermissionDetailViewController self =
        PermissionDetailViewController._create(parent);

    self.getWidgetControllerFormController = () {
      Rx<PermissionModel> rxModel = Rx<PermissionModel>(
          (self.parentController as PermissionTreeController)
              .permissionModel
              .value!);

      return self.detailViewFormController =
          EHEditFormController<PermissionModel>(
              widgetFocusNodes: self.detailViewFormController?.widgetFocusNodes,
              widgetKeys: self.detailViewFormController?.widgetKeys,
              dependentObxValues: [],
              rxModel: rxModel,
              widgetControllerBuilders: [
                () => EHTextFieldController(
                    labelMsgKey: 'common.general.displayName',
                    //autoFocus: true,
                    bindingFieldName: 'displayName',
                    mustInput: true,
                    onEditingComplete: (value) {}),
                () => EHDropDownController(
                      labelMsgKey: 'common.general.type',
                      mustInput: true,
                      width: 300,
                      bindingFieldName: 'type',
                      items: {
                        'P': 'common.security.permission',
                        'D': 'common.general.directory'
                      },
                      enabled: rxModel.value.id == null,
                      onChanged: (val) {
                        if (val == 'D') rxModel.value.authority = '';
                      },
                    ),
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.authorityCode',
                    //autoFocus: true,
                    bindingFieldName: 'authority',
                    mustInput: rxModel.value.type == 'P',
                    enabled:
                        rxModel.value.type == 'P' && rxModel.value.id == null,
                    onEditingComplete: (value) {}),
                () => EHFormDividerController(width: 1),
                () => EHTextFieldController(
                    enabled: false,
                    labelMsgKey: 'common.general.addWho',
                    //autoFocus: true,
                    bindingFieldName: 'addWho',
                    mustInput: false,
                    onEditingComplete: (value) {}),
                () => EHDatePickerController(
                      labelMsgKey: 'common.general.addDate',
                      enabled: false,
                      bindingFieldName: 'addDate',
                      showTimePicker: true,
                      onEditingComplete: (value) =>
                          {print('datepicker = onChange triggered')},
                    ),
                () => EHTextFieldController(
                    enabled: false,
                    labelMsgKey: 'common.general.editWho',
                    //autoFocus: true,
                    bindingFieldName: 'editWho',
                    mustInput: false,
                    onEditingComplete: (value) {}),
                () => EHDatePickerController(
                      enabled: false,
                      labelMsgKey: 'common.general.editDate',
                      bindingFieldName: 'editDate',
                      showTimePicker: true,
                      onEditingComplete: (value) => {},
                    ),
              ]);
    };
    return self;
  }
}
