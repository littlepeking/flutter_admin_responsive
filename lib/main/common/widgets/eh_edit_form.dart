import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/main/common/base/eh_exception.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_form_divider.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_multi_select.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_check_box.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_dropdown.dart';
import 'eh_custom_form_widget.dart';

typedef EHEditableWidgetController EHFormWidgetControllerBuilder();

typedef EHEditableWidget EHEditWidgetBuilder(Key key, FocusNode focusNode);

class EHEditForm<T extends EHModel>
    extends EHStatelessWidget<EHEditFormController<T>> {
  EHEditForm({Key? key, required EHEditFormController<T> controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    bool initilized = controller.widgets.length != 0;

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
                              if (!initilized) {
                                controller.widgets.add(Obx(() {
                                  return buildWidgetByWidgetBuilder(
                                      controller, builder);
                                }));
                              }
                              return controller.widgets[index];
                            }).toList()
                          : controller.widgetControllerBuilders!
                              .map((widgetController) {
                              int index = controller.widgetControllerBuilders!
                                  .indexOf(widgetController);

                              if (!initilized)
                                controller.widgets.add(buildWidgetByController(
                                    controller, widgetController));

                              return controller.widgets[index];
                            }).toList())
                ],
              ),
            )),
      ),
    );
  }

  EHEditableWidget buildWidgetByWidgetBuilder(
      EHEditFormController formController, EHEditWidgetBuilder builder) {
    int index = formController.widgetBuilders!.indexOf(builder);
    EHEditableWidget widget = builder(
        controller.widgetKeys![index], controller.widgetFocusNodes![index]);
    //widget will be recreated by obx each time, we need track lastest controller with same key assigned by EHEditForm.
    controller.widgetsControllers
        .removeWhere((c) => c.key == widget.controller.key);
    controller.widgetsControllers.add(widget.controller);
    return widget;
  }

  Obx buildWidgetByController(EHEditFormController formController,
      EHFormWidgetControllerBuilder controllerBuilder) {
    int index =
        formController.widgetControllerBuilders!.indexOf(controllerBuilder);

    EHEditableWidgetController controller = controllerBuilder();
    formController.widgetsControllers.add(controller);
    return Obx(() {
      controller.key = formController.widgetKeys![index];
      controller.focusNode = formController.widgetFocusNodes![index];
      controller.model = formController.rxModel!.value;
      controller.rxModel = formController.rxModel;

      controller.init();

      if (controller is EHTextFieldController) {
        return EHTextField(controller: controller);
      } else if (controller is EHCheckBoxController) {
        return EHCheckBox(controller: controller);
      } else if (controller is EHDropDownController) {
        return EHDropdown(controller: controller);
      } else if (controller is EHMultiSelectController) {
        return EHMultiSelect(controller: controller);
      } else if (controller is EHPopupController) {
        return EHPopup(controller: controller);
      } else if (controller is EHDatePickerController) {
        return EHDatePicker(controller: controller);
      } else if (controller is EHFormDividerController) {
        return EHFormDivider(controller: controller);
      } else if (controller is EHCustomFormWidgetController) {
        return EHCustomFormWidget<T>(
            controller: controller as EHCustomFormWidgetController<T>);
      } else {
        throw EHException('not implement yet');
      }
    });
  }
}

class EHEditFormController<T extends EHModel> extends EHController {
  EHEditFormController(
      {
      ////////////////////////////////////////////////////////////////////////
      ///Need this two parameters to make child correctly focused on EHEditFrom next rendering through Obx.
      ///It will keep form child widgets highlight but lose cursor without keeping widgetKeys,
      ///but good to find the issue and figure out the issue but I have no idea about the root cause so far.
      ////////////////////////////////////////////////////////////////////////
      this.widgetFocusNodes,
      this.widgetKeys,
      ////////////////////////////////////////////////////////////////////////
      this.widgetControllerBuilders,
      this.widgetBuilders,
      this.dependentObxValues,
      // this.model,
      this.rxModel,
      this.onChanged}) {
    if (this.widgetControllerBuilders == null && this.widgetBuilders == null)
      throw EHException(
          'widgetControllers and widgetBuilders need be provided at least one of them.');

    int widgetNumber = this.widgetControllerBuilders != null
        ? this.widgetControllerBuilders!.length
        : this.widgetBuilders!.length;

    widgetFocusNodes =
        widgetFocusNodes ?? List.generate(widgetNumber, (index) => FocusNode());
    widgetKeys =
        widgetKeys ?? List.generate(widgetNumber, (index) => GlobalKey());
  }

  List<EHEditWidgetBuilder>? widgetBuilders;

  List<EHFormWidgetControllerBuilder>? widgetControllerBuilders;

  late List<EHEditableWidgetController> widgetsControllers = [];

  List<Obx> widgets = [];

  List<FocusNode>? widgetFocusNodes;

  List<Key>? widgetKeys;

  //EHModel? model;
  Rx<T>? rxModel;

  void Function(T)? onChanged;

  //Create dependentObjects to let Obx know EHEditForm also need monitor these dependent Objects.
  //only need be used when need dynamically update EHEditableWidgetController's attributes other than model.
  List<Object?>? dependentObxValues;

  Future<bool> validate() async {
    bool isValid = true;
    for (int i = 0; i < widgetsControllers.length; i++) {
      isValid &= await widgetsControllers[i].validateWidget();
    }
    return isValid;
  }

  EHEditableWidgetController findWidgetControllerById(String id) {
    Iterable it = widgetsControllers.where((c) => c.id == id);

    if (it.length == 1) {
      return it.first;
    } else if (it.length == 0) {
      throw EHException('Widget Id $id is not found in current EHEditForm');
    } else {
      throw EHException(
          'More than one Widget Id $id are found in current EHEditForm, but it should be unique.');
    }
  }
}
