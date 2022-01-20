import 'package:admin/common/routing/routes.dart';
import 'package:admin/screens/home/home.dart';
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
