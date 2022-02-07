import 'package:eh_flutter_framework/main/common/base/EHStatelessWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestController.dart';

class Test2 extends EHStatelessWidget<TestController> {
  Test2({Key? key, controller}) : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          onPressed: () {
            controller.count++;
          },
          child: Text('add count')),
      Expanded(
          child: SizedBox(
              height: 50,
              child: DecoratedBox(
                  decoration: BoxDecoration(),
                  child: Center(child: Obx(() {
                    print(controller.toString());
                    return Text(controller.count.string);
                  }))))),
    ]);
  }
}
