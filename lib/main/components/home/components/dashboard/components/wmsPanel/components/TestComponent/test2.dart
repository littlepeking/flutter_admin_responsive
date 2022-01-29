import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestController.dart';

class Test2 extends StatefulWidget {
  final String? param;
  const Test2({Key? key, this.param}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2>
    with AutomaticKeepAliveClientMixin<Test2> {
  String? param;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Get.put(TestController());
    Get.create(() => TestController());
    TestController controller = Get.find();

    return Column(children: [
      Text(param ?? 'NO param'),
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

  @override
  bool get wantKeepAlive => true;
}
