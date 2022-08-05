import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

/// Tree view with collapsible and expandable nodes.
class EHMasterDetailSplitter
    extends EHStatelessWidget<EHMasterDetailSplitterController> {
  EHMasterDetailSplitter(
      {Key? key, required EHMasterDetailSplitterController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return controller.showDetail
        ? SplitView(
            children: [controller.masterPanel, controller.detailPanel],
            gripSize: controller.handleWidth,
            viewMode: SplitViewMode.Vertical,
            indicator: SplitIndicator(viewMode: SplitViewMode.Vertical),
            activeIndicator: SplitIndicator(
              viewMode: SplitViewMode.Vertical,
              isActive: true,
            ),
            controller: SplitViewController(
                limits: [WeightLimit(max: 0.7), WeightLimit(max: 0.7)],
                weights: [controller.splitterWeights]),
            // onWeightChanged: (w) =>
            //     controller.splitterWeights.value = w.first ?? 0.5,
          )
        : controller.masterPanel;
  }
}

class EHMasterDetailSplitterController extends EHController {
  late double splitterWeights = 0.5;
  bool showDetail;
  Widget masterPanel;
  Widget detailPanel;
  SplitViewMode viewMode;
  double handleWidth;
  EHMasterDetailSplitterController({
    this.viewMode = SplitViewMode.Vertical,
    this.handleWidth = 2,
    required this.showDetail,
    double splitterWeights = 0.5,
    required this.masterPanel,
    required this.detailPanel,
  }) {
    this.splitterWeights = splitterWeights;
  }
}
