import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditableWidget.dart';
import 'package:eh_flutter_framework/main/common/base/EHException.dart';
import 'package:eh_flutter_framework/main/common/base/EHModel.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/utils/EHRefactorHelper.dart';
import 'package:eh_flutter_framework/main/common/widgets/EH_multi_select.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_dropdown.dart';

typedef EHEditableWidgetController EHFormWidgetControllerBuilder();

class EHEditForm extends EHStatelessWidget<EHEditFormController> {
  EHEditForm({Key? key, required EHEditFormController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        // padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              // SingleActivator(LogicalKeyboardKey.tab): DoNothingIntent(),
            },
            child: FocusTraversalGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                      children: controller.widgetControllerBuilders == null
                          ? controller.widgetBuilders!.map((builder) {
                              int index =
                                  controller.widgetBuilders!.indexOf(builder);
                              return Obx(() => builder(
                                  controller.widgetKeys[index],
                                  controller.widgetFocusNodes[index]));
                            }).toList()
                          : controller.widgetControllerBuilders!
                              .map((widgetController) {
                              return buildWidgetByController(
                                  controller, widgetController);
                            }).toList())
                ],
              ),
            )),
      ),
    );
  }

  Widget buildWidgetByController(EHEditFormController formController,
      EHFormWidgetControllerBuilder controllerBuilder) {
    int index =
        formController.widgetControllerBuilders!.indexOf(controllerBuilder);

    return Obx(() {
      EHEditableWidgetController controller = controllerBuilder();
      controller.key = formController.widgetKeys[index];
      controller.focusNode = formController.widgetFocusNodes[index];
      controller.model = formController.rxModel!.value;
      controller.rxModel = formController.rxModel;
      if (controller is EHTextFieldController) {
        controller.text = (EHRefactorHelper.getFieldValue(
                controller.model!, controller.bindingFieldName!) ??
            '') as String;
        return EHTextField(key: controller.key!, controller: controller);
      } else if (controller is EHDropDownController) {
        controller.selectedValue = (EHRefactorHelper.getFieldValue(
                controller.model!, controller.bindingFieldName!) ??
            '') as String;
        return EHDropdown(key: controller.key!, controller: controller);
      } else if (controller is EHMultiSelectController) {
        controller.selectedValues = (EHRefactorHelper.getFieldValue(
                controller.model!, controller.bindingFieldName!) ??
            <String>[]) as List<String>;
        return EHMultiSelect(key: controller.key!, controller: controller);
      } else if (controller is EHPopupController) {
        controller.text = (EHRefactorHelper.getFieldValue(
                controller.model!, controller.bindingFieldName!) ??
            '') as String;
        return EHPopup(key: controller.key!, controller: controller);
      } else if (controller is EHDatePickerController) {
        Object? date = EHRefactorHelper.getFieldValue(
            controller.model!, controller.bindingFieldName!);
        controller.innerTextEditingController.text =
            controller.getBindingStringValue(date as DateTime?);
        controller.innerTextEditingController.focusNode = controller.focusNode;
        return EHDatePicker(key: controller.key!, controller: controller);
      } else {
        throw EHException('not implement yet');
      }
    });
  }
}

class EHEditFormController extends EHController {
  EHEditFormController(
      {this.widgetControllerBuilders,
      this.widgetBuilders,
      // this.model,
      this.rxModel,
      this.onChanged}) {
    if (this.widgetControllerBuilders == null && this.widgetBuilders == null)
      throw EHException(
          'widgetControllers and widgetBuilders need be provided at least one of them.');

    int widgetNumber = this.widgetControllerBuilders != null
        ? this.widgetControllerBuilders!.length
        : this.widgetBuilders!.length;

    widgetFocusNodes = List.generate(widgetNumber, (index) => FocusNode());
    widgetKeys = List.generate(widgetNumber, (index) => GlobalKey());
  }

  List<EHEditWidgetBuilder>? widgetBuilders;

  List<EHFormWidgetControllerBuilder>? widgetControllerBuilders;

  late List<EHEditableWidget> widgets;

  late List<FocusNode> widgetFocusNodes;

  late List<Key> widgetKeys;

  //EHModel? model;
  Rx<EHModel>? rxModel;

  void Function(EHModel)? onChanged;

  Future<bool> validate() async {
    bool isValid = true;
    for (int i = 0; i < widgets.length; i++) {
      isValid &= await widgets[i].validate();
    }
    return isValid;
  }
}

typedef EHEditableWidget EHEditWidgetBuilder(Key key, FocusNode focusNode);
