import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/common/base/EHEditableWidget.dart';
import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                      children: controller.widgetBuilders.map((builder) {
                    int index = controller.widgetBuilders.indexOf(builder);
                    return Obx(() => builder(controller.widgetKeys[index],
                        controller.widgetFocusNodes[index]));
                  }).toList())
                ],
              ),
            )),
      ),
    );
  }
}

class EHEditFormController extends EHController {
  EHEditFormController(this.widgetBuilders) {
    widgetFocusNodes =
        List.generate(widgetBuilders.length, (index) => FocusNode());
    widgetKeys = List.generate(widgetBuilders.length, (index) => GlobalKey());
  }

  List<EHEditWidgetBuilder> widgetBuilders;

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
