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
