import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_check_box.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/common/eh_security_constants.dart';
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
                  label: 'common.security.username',
                  //autoFocus: true,
                  bindingFieldName: 'username',
                  enabled: userModel.value.id == null,
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: 'common.security.firstName',
                  bindingFieldName: 'firstName',
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: 'common.security.lastName',
                  bindingFieldName: 'lastName',
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHDropDownController(
                  label: 'common.security.authType',
                  enabled: userModel.value.id == null,
                  mustInput: true,
                  bindingFieldName: 'authType',
                  items: getAuthTypeItems(),
                  onChanged: (value) async {
                    editFormController!.reset();
                  }),
              () => EHTextFieldController(
                  label: 'common.security.domainUsername',
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
                  label: 'common.security.newPassword',
                  hideText: true,
                  enabled: userModel.value.authType == EHAuthType.BASIC.name,
                  mustInput:
                      userModel.value.authType == EHAuthType.BASIC.name &&
                          userModel.value.id == null,
                  bindingFieldName: 'password',
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: 'common.security.verifyNewPassword',
                  hideText: true,
                  enabled: userModel.value.authType == EHAuthType.BASIC.name,
                  mustInput:
                      userModel.value.authType == EHAuthType.BASIC.name &&
                          userModel.value.id == null,
                  bindingFieldName: 'rePassword',
                  onEditingComplete: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHCheckBoxController(
                  label: 'common.general.isEnabled',
                  bindingFieldName: 'enabled',
                  onChanged: (v) {}),
              () => EHCheckBoxController(
                  label: 'common.security.accountLocked',
                  bindingFieldName: 'accountLocked',
                  onChanged: (v) {}),
              () => EHCheckBoxController(
                  enabled: userModel.value.authType == EHAuthType.BASIC.name,
                  label: 'common.security.credentialsExpired',
                  bindingFieldName: 'credentialsExpired',
                  onChanged: (v) {}),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  enabled: false,
                  label: 'common.general.addWho',
                  //autoFocus: true,
                  bindingFieldName: 'addWho',
                  mustInput: false,
                  onEditingComplete: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    label: 'common.general.addDate',
                    bindingFieldName: 'addDate',
                    mustInput: false,
                    onEditingComplete: (value) => {},
                  ),
              () => EHTextFieldController(
                  enabled: false,
                  label: 'common.general.editWho',
                  //autoFocus: true,
                  bindingFieldName: 'editWho',
                  mustInput: false,
                  onEditingComplete: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    label: 'common.general.editDate',
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
