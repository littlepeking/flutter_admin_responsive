import 'package:eh_flutter_framework/main/common/base/EHEditPanelController.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/wmsPanel/components/receipt/models/receipt_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ReceiptDetailViewController extends EHEditPanelController {
  FocusNode popUpFn = FocusNode();

  GlobalKey textKey1 = GlobalKey();
  GlobalKey textKey2 = GlobalKey();
  GlobalKey textKey3 = GlobalKey();
  GlobalKey popupKey1 = GlobalKey();
  GlobalKey dropdownKey1 = GlobalKey();
  GlobalKey dropdownKey2 = GlobalKey();
  FocusNode n = FocusNode();
  FocusNode n1 = FocusNode();
  FocusNode fnButton = FocusNode();

  Rx<ReceiptModel> receiptModel = ReceiptModel(
          receiptKey: 'key001',
          customerId: 'cus001',
          customerName: 'cus001Name',
          dropdownValue: '1')
      .obs;
}
