import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/scrollable_positioned_list/lib/item_positions_listener.dart';
import 'package:eh_flutter_framework/main/common/widgets/eh_tabs_view/scrollable_positioned_list/lib/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'eh_tabs_view_controller.dart';

class EHTabHeader extends StatelessWidget {
  final EHTabsViewController controller;

  EHTabHeader({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                controller.previous();
                // wmsItemScrollController.scrollTo(
                //     index: controller.selectedIndex.value,
                //     duration: Duration(milliseconds: 1),
                //     curve: Curves.decelerate);
              },
              icon: Icon(Icons.arrow_left)),
          Flexible(
              child: SizedBox(
                  height: 50,
                  child: Obx(
                    () => ScrollablePositionedList.builder(
                      initialScrollIndex: 0,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.tabsData.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return Container(
                            width: 150,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)),
                            alignment: Alignment.center,
                            child: InkWell(
                                child: Text(
                                  controller.tabsData[index].tabName.tr,
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () => controller.removeTab(index)));
                      },
                      itemScrollController: controller.itemScrollController,
                      itemPositionsListener: controller.itemPositionsListener,
                    ),
                  ))),
          IconButton(
              onPressed: () {
                controller.next();
                // wmsItemScrollController.jumpTo(
                //     index: controller.selectedIndex.value);
              },
              icon: Icon(Icons.arrow_right)),
          positionsView
        ],
      ),
    );
  }

  Widget get positionsView => ValueListenableBuilder<Iterable<ItemPosition>>(
        valueListenable: controller.itemPositionsListener.itemPositions,
        builder: (context, positions, child) {
          int? min;
          int? max;
          int? minFull;
          int? maxFull;
          if (positions.isNotEmpty) {
            // Determine the first visible item by finding the item with the
            // smallest trailing edge that is greater than 0.  i.e. the first
            // item whose trailing edge in visible in the viewport.
            min = positions
                .where((ItemPosition position) => position.itemTrailingEdge > 0)
                .reduce((ItemPosition min, ItemPosition position) =>
                    position.itemTrailingEdge < min.itemTrailingEdge
                        ? position
                        : min)
                .index;
            // Determine the last visible item by finding the item with the
            // greatest leading edge that is less than 1.  i.e. the last
            // item whose leading edge in visible in the viewport.
            max = positions
                .where((ItemPosition position) => position.itemLeadingEdge < 1)
                .reduce((ItemPosition max, ItemPosition position) =>
                    position.itemLeadingEdge > max.itemLeadingEdge
                        ? position
                        : max)
                .index;
            minFull = positions
                .where((ItemPosition position) => position.itemLeadingEdge >= 0)
                .reduce((ItemPosition min, ItemPosition position) =>
                    position.itemTrailingEdge < min.itemTrailingEdge
                        ? position
                        : min)
                .index;
            maxFull = positions
                .where((ItemPosition position) => position.itemTrailingEdge < 1)
                .reduce((ItemPosition max, ItemPosition position) =>
                    position.itemLeadingEdge > max.itemLeadingEdge
                        ? position
                        : max)
                .index;
            controller.minViewPortItemIndex.value = min;
            controller.maxViewPortItemIndex.value = max;
            controller.maxFullViewPortItemIndex.value = maxFull;
            controller.minFullViewPortItemIndex.value = minFull;
          }
          //测试使用
          return SizedBox(
            width: 0,
            height: 0, //50
            child: Column(
              children: <Widget>[
                Expanded(child: Text('First Item: ${min ?? ''}')),
                Expanded(child: Text('Last Item: ${max ?? ''}')),
                Expanded(child: Text('Last Full Item: ${maxFull ?? ''}'))
              ],
            ),
          );
        },
      );
}
