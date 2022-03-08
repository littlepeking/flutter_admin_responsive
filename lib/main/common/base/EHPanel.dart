import 'package:flutter/material.dart';

import 'EHPanelController.dart';
import 'EHStatelessWidget.dart';

abstract class EHPanel<T extends EHPanelController>
    extends EHStatelessWidget<T> {
  EHPanel({Key? key, required T controller})
      : super(key: key, controller: controller);
}
