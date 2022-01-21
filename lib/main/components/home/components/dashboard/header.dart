import 'package:eh_flutter_framework/main/controllers/menu_controller.dart';
import 'package:get/get.dart';

import '/common/Utils/responsive.dart';
import '/common/widgets/ImageButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/common/constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: MenuController.instance.controlMenu,
          ),
        // if (!Responsive.isMobile(context))
        //   Text(
        //     "WMS",
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        if (!Responsive.isMobile(context) && !Responsive.isTablet(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        // Expanded(flex: 2, child: SearchField()),
        ImageButton(
          text: 'Notification'.tr,
          icon: Icon(Icons.notifications),
          onPressed: () {
            // MainNavigationController.instance
            //     .navigateTo("/myTasks");
          },
        ),
        SizedBox(width: 0),
        ImageButton(
          text: 'Personalization'.tr,
          icon: Icon(Icons.account_circle),
          onPressed: () {
            // MainNavigationController.instance
            //     .navigateTo("/myTasks");
          },
        ),
        SizedBox(width: 0),
        ImageButton(
            text: 'changeTheme'.tr,
            icon: Icon(Icons.ac_unit_sharp),
            onPressed: () {
              Get.changeThemeMode(
                  Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            }),
        SizedBox(width: 0),
        ImageButton(
            text: 'changeLocale'.tr,
            icon: Icon(Icons.language),
            onPressed: () {
              var enLocale = Locale('en', 'US');
              var cnLocale = Locale('zh', 'CN');
              if (Get.locale == enLocale) {
                Get.updateLocale(cnLocale);
              } else {
                Get.updateLocale(enLocale);
              }
            }),
        SizedBox(width: 0),
        ImageButton(text: 'quit'.tr, icon: Icon(Icons.logout), onPressed: () {})
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: Theme.of(context).canvasColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
