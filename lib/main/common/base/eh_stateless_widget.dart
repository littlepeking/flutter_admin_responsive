import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EHStatelessWidget<T extends EHController>
    extends StatelessWidget {
  final T controller;

  EHStatelessWidget({Key? key, required this.controller}) : super(key: key);

  T findController<T extends EHController>() {
    return Get.find<T>();
  }
}
