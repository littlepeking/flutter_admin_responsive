import 'package:admin/controllers/test_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:admin/screens/dashboard/components/storage_details.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import 'my_tasks.dart';
import 'package:get/get.dart';

class MainPanelWidget extends GetView {
  const MainPanelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: LayoutBuilder(
                    builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                // Expanded(
                                //   child: MyTasks(),
                                // ),
                                SizedBox(height: 500),
                                Expanded(
                                  child: RecentFiles(),
                                ),
                                if (Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding),
                                if (Responsive.isMobile(context))
                                  StarageDetails(),
                                // middle widget goes here
                                Container(
                                    height: 300,
                                    child: Expanded(
                                        child: ListView(
                                      padding: const EdgeInsets.all(8),
                                      children: <Widget>[
                                        Text('List 1'),
                                        Text('List 2'),
                                        Text('List 3'),
                                      ],
                                    )
                                        //     child: Navigator(
                                        //   key: TestNavigationController
                                        //       .instance.navigatorKey,
                                        //   onGenerateRoute: generateRoute,
                                        //   initialRoute: mainNavigationMyTasksPageRoute,
                                        // )
                                        ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),

          // child: Column(
          //   children: [

          //   ],
          // ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // On Mobile means if the screen is less than 850 we dont want to show it
        if (!Responsive.isMobile(context))
          Expanded(
            flex: 2,
            child: StarageDetails(),
          ),
      ],
    ));
  }
}
