import 'package:get/get.dart';

class TestController extends GetxController {
  var count = 0.obs;

  @override
  onClose() {
    print("close test controller...");
  }
}
