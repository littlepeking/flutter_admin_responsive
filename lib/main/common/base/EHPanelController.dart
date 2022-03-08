import 'package:eh_flutter_framework/main/common/base/EHController.dart';

class EHPanelController extends EHController {
  EHPanelController? parent;
  EHPanelController? root;

  bool isRootController() {
    return root == null;
  }

  void initChildPanel(EHPanelController childPanelController) {
    childPanelController.parent = this;
    childPanelController.root = isRootController() ? this : root;
  }
}
