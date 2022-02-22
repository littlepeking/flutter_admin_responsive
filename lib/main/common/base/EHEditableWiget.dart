import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class EHEditableWidget<T extends EHController>
    extends StatelessWidget {
  final T controller;

  EHEditableWidget({Key? key, required this.controller}) : super(key: key);

  //return value: error string
  final String Function() validate = () => '';
}
