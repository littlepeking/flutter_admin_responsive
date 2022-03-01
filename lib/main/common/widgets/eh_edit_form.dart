import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditWidgetController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditableWidget.dart';
import 'package:eh_flutter_framework/main/common/base/EHException.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:eh_flutter_framework/main/common/widgets/EH_multi_select.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_date_picker.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_popup.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'eh_dropdown.dart';

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
                      children: controller.widgetControllers == null
                          ? controller.widgetBuilders!.map((builder) {
                              int index =
                                  controller.widgetBuilders!.indexOf(builder);
                              return Obx(() => builder(
                                  controller.widgetKeys[index],
                                  controller.widgetFocusNodes[index]));
                            }).toList()
                          : controller.widgetControllers!
                              .map((widgetController) {
                              return buildWidgetByController(widgetController);
                            }).toList())
                ],
              ),
            )),
      ),
    );
  }

  EHEditableWidget buildWidgetByController(
      EHEditableWidgetController widgetController) {
    int index = controller.widgetControllers!.indexOf(widgetController);
    widgetController.key = controller.widgetKeys[index];
    widgetController.focusNode = controller.widgetFocusNodes[index];
    if (widgetController is EHTextFieldController) {
      return EHTextField(
          key: widgetController.key!, controller: widgetController);
    } else if (widgetController is EHDropDownController) {
      return EHDropdown(
          key: widgetController.key!, controller: widgetController);
    } else if (widgetController is EHMultiSelectController) {
      return EHMultiSelect(
          key: widgetController.key!, controller: widgetController);
    } else if (widgetController is EHPopupController) {
      return EHPopup(key: widgetController.key!, controller: widgetController);
    } else if (widgetController is EHDatePickerController) {
      return EHDatePicker(
          key: widgetController.key!, controller: widgetController);
    } else {
      throw EHException('not implement yet');
    }
  }
}

class EHEditFormController extends EHController {
  EHEditFormController({this.widgetControllers, this.widgetBuilders}) {
    if (this.widgetControllers == null && this.widgetBuilders == null)
      throw EHException(
          'widgetControllers and widgetBuilders need be provided at least one of them.');

    int widgetNumber = this.widgetControllers != null
        ? this.widgetControllers!.length
        : this.widgetBuilders!.length;

    widgetFocusNodes = List.generate(widgetNumber, (index) => FocusNode());
    widgetKeys = List.generate(widgetNumber, (index) => GlobalKey());
  }

  List<EHEditableWidgetController>? widgetControllers;

  List<EHEditWidgetBuilder>? widgetBuilders;

  late List<EHEditableWidget> widgets;

  late List<FocusNode> widgetFocusNodes;

  late List<Key> widgetKeys;

  Future<bool> validate() async {
    bool isValid = true;
    for (int i = 0; i < widgets.length; i++) {
      isValid &= await widgets[i].validate();
    }
    return isValid;
  }
}

typedef EHEditableWidget EHEditWidgetBuilder(Key key, FocusNode focusNode);
