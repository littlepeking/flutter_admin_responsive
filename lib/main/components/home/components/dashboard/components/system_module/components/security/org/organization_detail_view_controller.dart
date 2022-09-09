import 'package:eh_flutter_framework/main/common/base/eh_panel_controller.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_dropdown.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_edit_form.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/common/common_data_sources.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_model.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/org/organization_tree_controller.dart';
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

    self.initData();

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
              dependentObxValues: [self.ddlType.value, self.orgItems.value],
              rxModel: rxModel,
              widgetControllerBuilders: [
                () => EHTextFieldController(
                    label: 'Organization Code',
                    //autoFocus: true,
                    bindingFieldName: 'code',
                    mustInput: true,
                    enabled: rxModel.value.id == null,
                    onEditingComplete: (value) {}),
                () => EHTextFieldController(
                    label: 'Organization Name',
                    //autoFocus: true,
                    bindingFieldName: 'name',
                    mustInput: true,
                    onEditingComplete: (value) {}),
                () => EHDropDownController(
                    label: 'Parent Organization',
                    enabled: false,
                    bindingFieldName: 'parentId',
                    items: self.orgItems,
                    onChanged: (value) {}),
                () => EHFormDividerController(width: 1),
                () => EHTextFieldController(
                    label: 'Address1',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'address1',
                    maxLines: 5,
                    onEditingComplete: (value) {}),
                () => EHTextFieldController(
                    label: 'Address2',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'address2',
                    maxLines: 5,
                    onEditingComplete: (value) {}),
                () => EHFormDividerController(width: 1),
                () => EHTextFieldController(
                    label: 'Contact1',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'contact1',
                    maxLines: 3,
                    onEditingComplete: (value) {}),
                () => EHTextFieldController(
                    label: 'Contact2',
                    //autoFocus: true,
                    width: 300,
                    bindingFieldName: 'contact2',
                    maxLines: 3,
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
                      label: 'Add Date',
                      enabled: false,
                      bindingFieldName: 'addDate',
                      showTimePicker: true,
                      onEditingComplete: (value) =>
                          {print('datepicker = onChange triggered')},
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
                      label: 'Edit Date',
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
