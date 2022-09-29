/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:enhantec_frontend_project/enhantec_ui_framework/base/eh_stateless_widget.dart';
import 'package:enhantec_frontend_project/enhantec_ui_framework/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TestController.dart';

class Test2 extends EHStatelessWidget<TestController> {
  Test2({Key? key, controller}) : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    print('focus===' + FocusScope.of(context).focusedChild.toString());
    return Column(children: [
      ElevatedButton(
          onPressed: () {
            controller.count++;
          },
          child: Text('add count')),
      !Responsive.isMobile(context)
          ? Expanded(
              child: SizedBox(
                  height: 50,
                  child: DecoratedBox(
                      decoration: BoxDecoration(),
                      child: Center(child: Obx(() {
                        print(controller.toString());
                        return Text(controller.count.string);
                      })))))
          : SizedBox(
              height: 50,
              child: DecoratedBox(
                  decoration: BoxDecoration(),
                  child: Center(child: Obx(() {
                    print(controller.toString());
                    return Text(controller.count.string);
                  }))))
    ]);
  }
}
