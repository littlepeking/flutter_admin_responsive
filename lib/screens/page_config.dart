import 'package:admin/controllers/main_navigation_controller.dart';
import 'package:admin/controllers/menu_controller.dart';
import 'package:admin/controllers/test_navigation_controller.dart';
import 'package:admin/routing/routes.dart';
import 'package:admin/screens/main/home.dart';
import 'package:get/get.dart';

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
