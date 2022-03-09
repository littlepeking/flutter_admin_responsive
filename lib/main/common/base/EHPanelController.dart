import 'package:eh_flutter_framework/main/common/base/EHController.dart';

class EHPanelController extends EHController {
  EHPanelController? parent;
  EHPanelController? root;

  EHPanelController(EHPanelController? parent) {
    this.parent = parent;
    this.root = parent == null ? this : parent.root;
  }

  bool isRootController() {
    return root == this;
  }

  // void initChildPanel(EHPanelController childPanelController) {
  //   childPanelController.parent = this;
  //   childPanelController.root = isRootController() ? this : root;
  // }
}
