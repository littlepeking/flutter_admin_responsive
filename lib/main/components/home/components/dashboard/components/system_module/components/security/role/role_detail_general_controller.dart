import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:get/get.dart';

import 'role_edit_controller.dart';
import 'role_model.dart';

class RoleDetailGeneralController extends EHPanelController {
  // ignore: avoid_init_to_null
  late EHEditFormController? editFormController = null;

  Function? getEditFormController;

  RoleDetailGeneralController(
      EHPanelController parent, Map<String, dynamic> params)
      : super(parent, params: params) {
    Rx<RoleModel> userModel = (parent as RoleEditController).model;

    getEditFormController =
        () => editFormController = EHEditFormController<RoleModel>(
            widgetFocusNodes: editFormController?.widgetFocusNodes,
            widgetKeys: editFormController?.widgetKeys,
            dependentObxValues: [userModel.value],
            rxModel: userModel,
            widgetControllerBuilders: [
              () => EHTextFieldController(
                  label: 'roleName',
                  //autoFocus: true,
                  bindingFieldName: 'roleName',
                  enabled: userModel.value.id == null,
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: 'Display Name',
                  bindingFieldName: 'displayName',
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  enabled: false,
                  label: 'Add Who',
                  //autoFocus: true,
                  bindingFieldName: 'addWho',
                  mustInput: false,
                  onEditingComplete: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    label: 'Add Date',
                    bindingFieldName: 'addDate',
                    mustInput: false,
                    onEditingComplete: (value) => {},
                  ),
              () => EHTextFieldController(
                  enabled: false,
                  label: 'Edit Who',
                  //autoFocus: true,
                  bindingFieldName: 'editWho',
                  mustInput: false,
                  onEditingComplete: (value) {}),
              () => EHDatePickerController(
                    enabled: false,
                    showTimePicker: true,
                    label: 'Edit Date',
                    bindingFieldName: 'editDate',
                    mustInput: false,
                    onEditingComplete: (value) => {},
                  ),
            ]);
  }
}
