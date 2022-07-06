import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:flutter/material.dart';

class EHPanelController extends EHController {
  EHPanelController? parentController;
  EHPanelController? rootController;

  EHPanelController(EHPanelController? parentController) {
    this.parentController = parentController;
    this.rootController =
        parentController == null ? this : parentController.rootController;
  }

  bool isRootController() {
    return rootController == this;
  }

  // void initChildPanel(EHPanelController childPanelController) {
  //   childPanelController.parent = this;
  //   childPanelController.root = isRootController() ? this : root;
  // }
}
