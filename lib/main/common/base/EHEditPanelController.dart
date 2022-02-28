import 'package:eh_flutter_framework/main/common/base/EHController.dart';

class EHEditFormController extends EHController {
  Map errorBucket = {};

  Future<bool> Function() validateForm = () async => true;
}
