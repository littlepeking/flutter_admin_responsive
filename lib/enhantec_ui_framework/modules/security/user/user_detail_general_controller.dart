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
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_check_box.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_date_picker.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_dropdown.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_edit_form.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_form_divider.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/widgets/eh_text_field.dart';
import 'package:enhantec_platform_ui/enhantec_ui_framework/modules/security/common/eh_security_constants.dart';
import 'package:get/get.dart';

import 'user_edit_controller.dart';
import 'user_model.dart';

class UserDetailGeneralController extends EHPanelController {
  // ignore: avoid_init_to_null
  late EHEditFormController? editFormController = null;

  Function? getEditFormController;

  UserDetailGeneralController(
      EHPanelController parent, Map<String, dynamic> params)
      : super(parent, params: params) {
    Rx<UserModel> userModel = (parent as UserEditController).model;

    getEditFormController =
        () => editFormController = EHEditFormController<UserModel>(
            widgetFocusNodes: editFormController?.widgetFocusNodes,
            widgetKeys: editFormController?.widgetKeys,
            dependentObxValues: [userModel.value],
            rxModel: userModel,
            widgetControllerBuilders: [
              () => EHTextFieldController(
                  labelMsgKey: 'common.security.username',
                  //autoFocus: true,
                  bindingFieldName: 'username',
                  enabled: userModel.value.id == null,
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  labelMsgKey: 'common.security.firstName',
                  bindingFieldName: 'firstName',
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  labelMsgKey: 'common.security.lastName',
                  bindingFieldName: 'lastName',
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHDropDownController(
                  labelMsgKey: 'common.security.authType',
                  enabled: userModel.value.id == null,
                  mustInput: true,
                  bindingFieldName: 'authType',
                  items: getAuthTypeItems(),
                  onChanged: (value) async {
                    editFormController!.reset();
                  }),
              () => EHTextFieldController(
                  labelMsgKey: 'common.security.domainUsername',
                  bindingFieldName: 'domainUsername',
                  enabled: false, //POPULATE BY BACKEND
                  onEditingComplete: (value) {}),
              // () => EHTextFieldController(
              //     label: 'Original Password',
              //     enabled: userModel.value.authType == EHAuthType.BASIC.name &&
              //         userModel.value.id != null,
              //     bindingFieldName: 'originalPassword',
              //     onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  labelMsgKey: 'common.security.newPassword',
                  hideText: true,
                  enabled: userModel.value.authType == EHAuthType.BASIC.name,
                  mustInput:
                      userModel.value.authType == EHAuthType.BASIC.name &&
                          userModel.value.id == null,
                  bindingFieldName: 'password',
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  labelMsgKey: 'common.security.verifyNewPassword',
                  hideText: true,
                  enabled: userModel.value.authType == EHAuthType.BASIC.name,
                  mustInput:
                      userModel.value.authType == EHAuthType.BASIC.name &&
                          userModel.value.id == null,
                  bindingFieldName: 'rePassword',
                  onEditingComplete: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHCheckBoxController(
                  labelMsgKey: 'common.general.isEnabled',
                  bindingFieldName: 'enabled',
                  onChanged: (v) {}),
              () => EHCheckBoxController(
                  labelMsgKey: 'common.security.accountLocked',
                  bindingFieldName: 'accountLocked',
                  onChanged: (v) {}),
              () => EHCheckBoxController(
                  enabled: userModel.value.authType == EHAuthType.BASIC.name,
                  labelMsgKey: 'common.security.credentialsExpired',
                  bindingFieldName: 'credentialsExpired',
                  onChanged: (v) {}),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  enabled: false,
                  labelMsgKey: 'common.general.addWho',
                  //autoFocus: true,
                  bindingFieldName: 'addWho',
                  mustInput: false,
                  onEditingComplete: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    labelMsgKey: 'common.general.addDate',
                    bindingFieldName: 'addDate',
                    mustInput: false,
                    onEditingComplete: (value) => {},
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
                    showTimePicker: true,
                    labelMsgKey: 'common.general.editDate',
                    bindingFieldName: 'editDate',
                    mustInput: false,
                    onEditingComplete: (value) => {},
                  ),
            ]);
  }

  Map<String, String> getAuthTypeItems() {
    Map<String, String> res = Map();

    EHAuthType.values.forEach((e) => res[e.name] = e.name);

    return res;
  }
}
