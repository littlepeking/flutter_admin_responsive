import 'package:flutter/material.dart';

import 'eh_panel_controller.dart';
import 'eh_stateless_widget.dart';

abstract class EHPanel<T extends EHPanelController>
    extends EHStatelessWidget<T> {
  EHPanel({Key? key, required T controller})
      : super(key: key, controller: controller);
}
