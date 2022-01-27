import 'package:flutter/material.dart';

class TabData {
  String tabName;
  Widget widget;
  bool isActive;
  bool closable;

  TabData(this.tabName, this.widget,
      {this.isActive = true, this.closable = false});
}
