import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_check_box.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:get/get.dart';

import 'user_edit_controller.dart';
import 'user_model.dart';

class UserDetailGeneralController extends EHPanelController {
  // ignore: avoid_init_to_null
  late EHEditFormController? editFormController = null;

  Function? getEditFormController;

  UserDetailGeneralController(EHPanelController parent) : super(parent) {
    Rx<UserModel> userModel = (parent as UserEditController).model;

    getEditFormController =
        () => editFormController = EHEditFormController<UserModel>(
            widgetFocusNodes: editFormController?.widgetFocusNodes,
            widgetKeys: editFormController?.widgetKeys,
            dependentObxValues: [userModel.value],
            rxModel: userModel,
            widgetControllerBuilders: [
              () => EHTextFieldController(
                  label: 'Username',
                  //autoFocus: true,
                  bindingFieldName: 'username',
                  mustInput: true,
                  onChanged: (value) {}),
              () => EHDropDownController(
                  label: 'Auth Type',
                  mustInput: true,
                  bindingFieldName: 'authType',
                  items: {
                    'BASIC': 'BASIC',
                    'LDAP': 'LDAP',
                  },
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: 'Domain Username',
                  bindingFieldName: 'domainUsername',
                  mustInput: false,
                  onChanged: (value) {}),
              () => EHCheckBoxController(
                  label: 'Enabled',
                  bindingFieldName: 'enabled',
                  onChanged: (v) {}),
              () => EHCheckBoxController(
                  label: 'Account Locked',
                  bindingFieldName: 'accountLocked',
                  onChanged: (v) {}),
              () => EHCheckBoxController(
                  label: 'Credentials Expired',
                  bindingFieldName: 'credentialsExpired',
                  onChanged: (v) {}),
              () => EHTextFieldController(
                  enabled: false,
                  label: 'Add Who',
                  //autoFocus: true,
                  bindingFieldName: 'addWho',
                  mustInput: false,
                  onChanged: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    label: 'Add Date',
                    bindingFieldName: 'addDate',
                    mustInput: false,
                    onChanged: (value) => {},
                  ),
              () => EHTextFieldController(
                  enabled: false,
                  label: 'Edit Who',
                  //autoFocus: true,
                  bindingFieldName: 'editWho',
                  mustInput: false,
                  onChanged: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    label: 'Edit Date',
                    bindingFieldName: 'editDate',
                    mustInput: false,
                    onChanged: (value) => {},
                  ),
            ]);
  }
}
