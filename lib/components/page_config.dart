import '/common/routing/routes.dart';
import 'package:get/get.dart';

import 'home/home.dart';

List<GetPage<dynamic>>? pageConfig = [
  GetPage(
    name: rootRoute,
    page: () => Home(),
    binding: BindingsBuilder(() {
      // Get.lazyPut<MenuController>(() => MenuController());
      // Get.lazyPut<MainNavigationController>(() => MainNavigationController());
      // Get.lazyPut<TestNavigationController>(() => TestNavigationController());
      // Get.put<Service>(() => Api());
    }),
  ),
];
