import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';

class EHPanelController extends EHController {
  EHPanelController? parentController;
  EHPanelController? rootController;

  Map<String, dynamic> params;

  EHPanelController(EHPanelController? parentController,
      {this.params = const {}}) {
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
