import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_header.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHTabsView extends StatelessWidget {
  final EHTabsViewController controller;

  EHTabsView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EHTabHeader(controller: controller),
        Flexible(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Obx(() => IndexedStack(
                  index: controller.selectedIndex.value,
                  children: controller.tabsData.map((data) {
                    return Container(
                      alignment: Alignment.topLeft,
                      //color: Colors.grey,
                      child: data.widget,
                    );
                  }).toList(),
                  //[
                  // SingleChildScrollView(
                  //   child: SizedBox(
                  //     height: 1000,
                  //     // width: 500,
                  //     child: Container(
                  //       color: Colors.red,
                  //       child: Test2(),
                  //     ),
                  //   ),
                  // ),
                  //]
                )),
          ),
        )
      ],
    );
  }
}
