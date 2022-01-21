import 'package:eh_flutter_framework/main/components/home/home.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? pageConfig = [
  GetPage(
    name: '/',
    page: () => Home(),
    binding: BindingsBuilder(() {
      // Get.lazyPut<MenuController>(() => MenuController());
      // Get.lazyPut<MainNavigationController>(() => MainNavigationController());
      // Get.lazyPut<TestNavigationController>(() => TestNavigationController());
      // Get.put<Service>(() => Api());
    }),
  ),
];
