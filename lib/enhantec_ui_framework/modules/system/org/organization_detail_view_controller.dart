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

import 'package:enhantec_platform_ui/enhantec_ui_framework/base/eh_panel_controller.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_date_picker.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_dropdown.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_edit_form.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_form_divider.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_text_field.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/common/common_data_sources.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/organization_model.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/system/org/organization_tree_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class OrganizationDetailViewController extends EHPanelController {
  RxString ddlType = '0'.obs;
  RxMap<String, String> orgItems = Map<String, String>().obs;

  //Here we need set controller to null expliciltly, otherwise OrganizationDetailViewController constructor will cannot assign init value to getWidgetControllerFormController
  // ignore: avoid_init_to_null
  late EHEditFormController? orgDetailViewFormController = null;

  Function? getWidgetControllerFormController;

  OrganizationDetailViewController._create(EHPanelController parent)
      : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<OrganizationDetailViewController> create(
      EHPanelController parent) async {
    OrganizationDetailViewController self =
        OrganizationDetailViewController._create(parent);

    await self.initData();

    self.getWidgetControllerFormController = () {
      Rx<OrganizationModel> rxModel = Rx<OrganizationModel>(
          (self.parentController as OrganizationTreeController)
              .orgModel
              .value!);

      return self.orgDetailViewFormController =
          EHEditFormController<OrganizationModel>(
              widgetFocusNodes:
                  self.orgDetailViewFormController?.widgetFocusNodes,
              widgetKeys: self.orgDetailViewFormController?.widgetKeys,
              // ignore: invalid_use_of_protected_member
              dependentObxValues: [self.ddlType.value, self.orgItems.value],
              rxModel: rxModel,
              widgetControllerBuilders: [
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.organizationCode',
                    //autoFocus: true,
                    bindingFieldName: 'code',
                    mustInput: true,
                    enabled: rxModel.value.id == null,
                    onEditingComplete: (value) {}),
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.orgName',
                    //autoFocus: true,
                    bindingFieldName: 'name',
                    mustInput: true,
                    onEditingComplete: (value) {}),
                () => EHDropDownController(
                    labelMsgKey: 'common.security.parentOrg',
                    enabled: false,
                    bindingFieldName: 'parentId',
                    items: self.orgItems,
                    onChanged: (value) {}),
                () => EHFormDividerController(width: 1),
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.address1',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'address1',
                    maxLines: 5,
                    onEditingComplete: (value) {}),
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.address2',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'address2',
                    maxLines: 5,
                    onEditingComplete: (value) {}),
                () => EHFormDividerController(width: 1),
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.contact1',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'contact1',
                    maxLines: 3,
                    onEditingComplete: (value) {}),
                () => EHTextFieldController(
                    labelMsgKey: 'common.security.contact2',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'contact2',
                    maxLines: 3,
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

  Future<void> initData() async {
    //need reload org ddl after org saved
    orgItems.value = await CommonDataSources.getOrgDDLDataSource();
  }
}
