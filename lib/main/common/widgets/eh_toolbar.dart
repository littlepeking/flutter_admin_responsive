import 'package:flutter/material.dart';

class EHToolBar extends StatelessWidget {
  EHToolBar({required this.children});

  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //  height: 36,
        child: Wrap(children: children));
  }
}
