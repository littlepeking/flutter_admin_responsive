/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

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
      Get.lazyPut<SideMenuController>(() => SideMenuController(null));
    }),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
    binding: BindingsBuilder(() {}),
  ),
];
