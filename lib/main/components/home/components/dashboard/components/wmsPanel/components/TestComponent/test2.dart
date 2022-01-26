import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestController.dart';

class Test2 extends GetWidget<TestController> {
  final String? tabName;

  const Test2({Key? key, this.tabName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.create(() => TestController());

    return Column(children: [
      Text(tabName ?? 'NO NAME'),
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
