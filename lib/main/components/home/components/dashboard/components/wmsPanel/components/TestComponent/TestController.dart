import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:get/get.dart';

class TestController extends EHController {
  var count = 0.obs;

  @override
  onClose() {
    print("close test controller...");
  }
}
