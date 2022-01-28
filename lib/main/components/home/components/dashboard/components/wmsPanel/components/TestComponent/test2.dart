import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestController.dart';

class Test2 extends StatefulWidget {
  final String? tabName;
  const Test2({Key? key, this.tabName}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2>
    with AutomaticKeepAliveClientMixin<Test2> {
  String? tabName;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //Get.put(TestController());
    Get.create(() => TestController());
    TestController controller = Get.find();

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

  @override
  bool get wantKeepAlive => true;
}
