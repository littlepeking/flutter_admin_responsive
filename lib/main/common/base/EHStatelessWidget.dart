import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EHStatelessWidget<T extends GetxController>
    extends StatelessWidget {
  final T controller;

  EHStatelessWidget({Key? key, required this.controller}) : super(key: key);

  T findController<T extends EHController>() {
    return Get.find<T>();
  }
}
