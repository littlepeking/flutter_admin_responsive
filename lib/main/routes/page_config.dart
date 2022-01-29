import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:eh_flutter_framework/main/components/home/home.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? pageConfig = [
  GetPage(
    name: '/',
    page: () => Home(),
    binding: BindingsBuilder(() {
      Get.lazyPut<SideMenuController>(() => SideMenuController());
    }),
  ),
];
