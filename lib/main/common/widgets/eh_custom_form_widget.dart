import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_editable_widget.dart';
import 'package:eh_flutter_framework/main/common/base/eh_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHCustomFormWidget<T extends EHModel>
    extends EHEditableWidget<EHCustomFormWidgetController<T>> {
  EHCustomFormWidget({
    required EHCustomFormWidgetController<T> controller,
  }) : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    //Remove obx if widget does not use observable object value and we can cheat obx to force refresh by utilizing print() function =)
    //return Obx(() {
    if (controller._child == null) {
      Widget widget = controller.widgetBuilder(
          controller.key, controller.focusNode, controller.rxModel);
      controller._child = widget;
      //print(controller.rxModel!.toJson());
    }
    return controller._child!;
    //});
  }
}

class EHCustomFormWidgetController<T extends EHModel>
    extends EHEditableWidgetController<T> {
  EHCustomFormWidgetController({required this.widgetBuilder});

  Widget? _child;

  Widget Function(Key? key, FocusNode? focusNode, Rx<T>? rxModel) widgetBuilder;

  @override
  validateWidget() {
    if (_child is EHValidationWidget) {
      return (_child as EHValidationWidget).validate();
    } else
      return true;
  }
}

abstract class EHValidationWidget extends StatelessWidget {
  bool validate();
}
