import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

/// Tree view with collapsible and expandable nodes.
class EHMasterDetailSplitView
    extends EHStatelessWidget<EHMasterDetailSplitterController> {
  EHMasterDetailSplitView(
      {Key? key, required EHMasterDetailSplitterController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return controller.showDetail
        ? SplitView(
            children: [controller.masterPanel, controller.detailPanel],
            gripSize: controller.handleWidth,
            viewMode: controller.viewMode,
            indicator: SplitIndicator(viewMode: controller.viewMode),
            activeIndicator: SplitIndicator(
              viewMode: controller.viewMode,
              isActive: true,
            ),
            controller: SplitViewController(limits: [
              WeightLimit(max: controller.maxWeight),
              WeightLimit(max: controller.maxWeight)
            ], weights: [
              controller.splitterWeights
            ]),
            // onWeightChanged: (w) =>
            //     controller.splitterWeights.value = w.first ?? 0.5,
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: controller.masterPanel)],
          );
  }
}

class EHMasterDetailSplitterController extends EHController {
  late double splitterWeights = 0.5;
  late double maxWeight = 0.5;
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
    double maxWeight = 0.7,
    required this.masterPanel,
    required this.detailPanel,
  }) {
    this.splitterWeights = splitterWeights;
    this.maxWeight = maxWeight;
  }
}
