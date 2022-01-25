import 'dart:math';

import 'package:eh_flutter_framework/main/common/widgets/scrollable_positioned_list/lib/item_positions_listener.dart';
import 'package:eh_flutter_framework/main/common/widgets/scrollable_positioned_list/lib/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    ItemScrollController wmsItemScrollController = ItemScrollController();

    return Row(
      children: [
        IconButton(
            onPressed: () {
              wmsItemScrollController.scrollTo(
                  index: 1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
            icon: Icon(Icons.arrow_left)),
        Flexible(
            child: ScrollablePositionedList.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                alignment: Alignment.center,
                child: Text(
                  Random().nextInt(100).toString(),
                  textAlign: TextAlign.center,
                ));
          },
          itemScrollController: wmsItemScrollController,
          itemPositionsListener: itemPositionsListener,
        )),
        IconButton(
            onPressed: () {
              wmsItemScrollController.scrollTo(
                  index: 2,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            },
            icon: Icon(Icons.arrow_right)),
      ],
    );
  }
}
