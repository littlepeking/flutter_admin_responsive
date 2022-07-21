import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_tree_controller.dart';

import 'package:get/get.dart';

class OrganizationDetailViewController extends EHPanelController {
  RxString ddlType = '0'.obs;

  //Here we need set controller to null expliciltly, otherwise OrganizationDetailViewController constructor will cannot assign init value to getWidgetControllerFormController
  // ignore: avoid_init_to_null
  late EHEditFormController? widgetControllerFormController = null;

  Function? getWidgetControllerFormController;

  OrganizationDetailViewController(EHPanelController parent) : super(parent) {
    getWidgetControllerFormController = () => widgetControllerFormController =
        EHEditFormController<OrganizationModel>(
            widgetFocusNodes: widgetControllerFormController?.widgetFocusNodes,
            widgetKeys: widgetControllerFormController?.widgetKeys,
            dependentObxValues: [ddlType.value],
            rxModel: Rx<OrganizationModel>(
                (parentController as OrganizationTreeController).model.value!),
            widgetControllerBuilders: [
              () => EHTextFieldController(
                  label: 'Organization Name',
                  //autoFocus: true,
                  bindingFieldName: 'name',
                  mustInput: true,
                  onChanged: (value) {}),
              () => EHDropDownController(
                  label: 'Parent Organization',
                  enabled: false,
                  bindingFieldName: 'parentId',
                  items: {
                    '0': 'Item0',
                    '1': 'Item1',
                    '2': 'Item2',
                  },
                  onChanged: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  label: 'Address1',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'address1',
                  maxLines: 5,
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: 'Address2',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'address2',
                  maxLines: 5,
                  onChanged: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHTextFieldController(
                  label: 'Contact1',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'contact1',
                  maxLines: 3,
                  onChanged: (value) {}),
              () => EHTextFieldController(
                  label: 'Contact2',
                  //autoFocus: true,
                  width: 300,
                  bindingFieldName: 'contact2',
                  maxLines: 3,
                  onChanged: (value) {}),
              () => EHFormDividerController(width: 1),
              () => EHDatePickerController(
                    label: 'Add Date',
                    enabled: false,
                    bindingFieldName: 'addDate',
                    showTimePicker: true,
                    onChanged: (value) =>
                        {print('datepicker = onChange triggered')},
                  ),
              () => EHDatePickerController(
                    enabled: false,
                    label: 'Edit Date',
                    bindingFieldName: 'editDate',
                    showTimePicker: true,
                    onChanged: (value) => {},
                  ),
            ]);
  }

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
