import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:flutter/material.dart';

abstract class EHEditableWidget<T extends EHEditableWidgetController>
    extends StatelessWidget {
  final T controller;

  EHEditableWidget({Key? key, required this.controller}) : super(key: key) {
    if (this.controller.key == null) this.controller.key = key ?? GlobalKey();
  }

  Future<bool> validate() async {
    return await controller.validateWidget();
  }
}
