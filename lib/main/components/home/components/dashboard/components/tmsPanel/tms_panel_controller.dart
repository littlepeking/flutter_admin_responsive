import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/eh_tabs_view_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TmsPanelController extends GetxController {
  EHTabsViewController tabViewController = EHTabsViewController();

  reset() {
    tabViewController.reset();
  }
}
