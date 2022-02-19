import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:get/get.dart';

class EHEditFormController extends EHController {
  Map errorBucket = {};

  Future<bool> Function() validateForm = () async => true;
}
