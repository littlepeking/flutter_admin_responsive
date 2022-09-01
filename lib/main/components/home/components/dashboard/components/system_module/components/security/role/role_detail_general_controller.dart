import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/common/common_data_sources.dart';
import 'package:get/get.dart';

import 'role_edit_controller.dart';
import 'role_model.dart';

class RoleDetailGeneralController extends EHPanelController {
  // ignore: avoid_init_to_null
  late EHEditFormController? editFormController = null;

  Function? getEditFormController;

  RxMap<String, String> orgItems = Map<String, String>().obs;

  RoleDetailGeneralController._create(EHPanelController parent) : super(parent);

  //since dart does not support asyc constructor, so we have to create a static function to create instance through a private constructor '_create' (we also need this private constructor to call super constructor) and then mark this static function as async.
  //https://stackoverflow.com/questions/38933801/calling-an-async-method-from-component-constructor-in-dart
  static Future<RoleDetailGeneralController> create(
      EHPanelController parent, Map<String, dynamic> params) async {
    RoleDetailGeneralController self =
        RoleDetailGeneralController._create(parent);

    Rx<RoleModel> userModel = (parent as RoleEditController).model;

    self.orgItems.value = await CommonDataSources.getOrgDDLDataSource();

    self.getEditFormController =
        () => self.editFormController = EHEditFormController<RoleModel>(
            widgetFocusNodes: self.editFormController?.widgetFocusNodes,
            widgetKeys: self.editFormController?.widgetKeys,
            dependentObxValues: [userModel.value],
            rxModel: userModel,
            widgetControllerBuilders: [
              () => EHTextFieldController(
                  label: 'Role Name',
                  //autoFocus: true,
                  bindingFieldName: 'roleName',
                  //enabled: userModel.value.id == null,
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHTextFieldController(
                  label: 'Display Name',
                  bindingFieldName: 'displayName',
                  mustInput: true,
                  onEditingComplete: (value) {}),
              () => EHDropDownController(
                  label: 'Organization',
                  enabled: false,
                  bindingFieldName: 'orgId',
                  items: self.orgItems,
                  onChanged: (value) {}),
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

    return self;
  }
}
