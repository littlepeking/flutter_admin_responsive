import 'package:eh_flutter_framework/main/common/services/common/eh_base_service.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:get/get.dart';

class ReceiptService extends EHBaseService<ReceiptModel> {
  static ReceiptService getInstance() {
    return Get.put(ReceiptService());
  }

  @override
  String get serviceName => 'receipts';
}
