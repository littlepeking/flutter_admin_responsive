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

import 'package:flutter/widgets.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Function getChildWidget;
  const StatefulWrapper({this.onInit, required this.getChildWidget});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  bool isDataInited = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    if (widget.onInit != null) {
      await widget.onInit!();
      setState(() {
        isDataInited = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isDataInited)
      return widget.getChildWidget();
    else
      return SizedBox.shrink();
  }
}
