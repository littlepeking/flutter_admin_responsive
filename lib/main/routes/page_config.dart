import 'package:eh_flutter_framework/main/components/home/components/side_menu/side_menu_controller.dart';
import 'package:eh_flutter_framework/main/components/home/home.dart';
import 'package:get/get.dart';

import '../components/login/login_screen.dart';

List<GetPage<dynamic>>? pageConfig = [
  GetPage(
    name: '/',
    page: () => Home(),
    //transition: Transition.,
    // transitionDuration: const Duration(milliseconds: 250),
    binding: BindingsBuilder(() {
      Get.lazyPut<SideMenuController>(() => SideMenuController());
    }),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
    binding: BindingsBuilder(() {}),
  ),
];
