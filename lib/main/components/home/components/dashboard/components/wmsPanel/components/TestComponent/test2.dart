import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestController.dart';

class Test2 extends GetWidget<TestController>
    with AutomaticKeepAliveClientMixin {
  Test2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.create<TestController>(() => TestController());

    return Column(children: [
      ElevatedButton(
          onPressed: () => controller.count++, child: Text('add count')),
      Expanded(
          child: SizedBox(
              height: 50,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Center(
                      child: Obx(() => Text(controller.count.string)))))),
      Expanded(child: Container())
    ]);
  }
}
