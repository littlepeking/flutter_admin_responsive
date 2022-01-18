import 'package:admin/controllers/test_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import '../dashboard//components/my_tasks.dart';
import 'package:get/get.dart';

class DashboardScreen extends GetView {
  const DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Text("Header"),
                  Text("Footer"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
