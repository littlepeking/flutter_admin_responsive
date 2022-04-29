import 'package:eh_flutter_framework/main/common/services/common/eh_base_model_service.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';

import '../service_name.dart';

class ReceiptService extends EHBaseModelService<ReceiptModel> {
  ReceiptService._internal();

  static ReceiptService _singleton = new ReceiptService._internal();

  factory ReceiptService() => _singleton;

  // static ReceiptService getInstance() {
  //   return Get.put(ReceiptService(), permanent: true);
  // }

  @override
  String get serviceName => WMSServiceNames.ReceiptService;
}
