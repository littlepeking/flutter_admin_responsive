import 'package:eh_flutter_framework/main/common/base/eh_edit_widget_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:flutter/material.dart';

class EHButton extends EHStatelessWidget<EHButtonController> {
  EHButton({Key? key, required EHButtonController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 28,
        child: ElevatedButton(
          onPressed: controller.onPressed,
          child: controller.child,
        ),
      ),
    );
  }
}

class EHButtonController extends EHEditableWidgetController {
  @override
  Future<bool> validateWidget() async {
    return true;
  }

  VoidCallback? onPressed;

  Widget child;

  EHButtonController({
    this.onPressed,
    required this.child,
  });
}
