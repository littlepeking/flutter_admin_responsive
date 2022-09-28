/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

import 'package:eh_flutter_framework/main/common/base/eh_controller.dart';
import 'package:eh_flutter_framework/main/common/base/eh_stateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';

class EHMasterDetailSplitView
    extends EHStatelessWidget<EHMasterDetailSplitterController> {
  EHMasterDetailSplitView(
      {Key? key, required EHMasterDetailSplitterController controller})
      : super(key: key, controller: controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: controller.padding,
        child: controller.showDetail || controller.placeHolderWidget != null
            ? SplitView(
                children: [
                  controller.masterPanel,
                  if (controller.showDetail) controller.detailPanel,
                  if (!controller.showDetail &&
                      controller.placeHolderWidget != null)
                    controller.placeHolderWidget!
                ],
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
              ));
  }
}

class EHMasterDetailSplitterController extends EHController {
  late double splitterWeights = 0.5;
  late double maxWeight = 0.5;
  EdgeInsets padding;
  bool showDetail;
  Widget masterPanel;
  Widget detailPanel;
  SplitViewMode viewMode;
  double handleWidth;
  Widget? placeHolderWidget;

  EHMasterDetailSplitterController(
      {this.viewMode = SplitViewMode.Vertical,
      this.handleWidth = 2,
      this.padding = const EdgeInsets.all(2),
      required this.showDetail,
      double splitterWeights = 0.5,
      double maxWeight = 0.8,
      required this.masterPanel,
      required this.detailPanel,
      this.placeHolderWidget}) {
    this.splitterWeights = splitterWeights;
    this.maxWeight = maxWeight;
  }
}
