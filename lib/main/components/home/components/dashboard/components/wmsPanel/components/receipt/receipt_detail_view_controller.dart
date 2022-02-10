import 'package:eh_flutter_framework/main/common/base/EHController.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ReceiptDetailViewController extends EHController {
  Rx<ReceiptModel> receiptModel =
      ReceiptModel(receiptKey: 'key001', customerName: 'cus001').obs;
}
