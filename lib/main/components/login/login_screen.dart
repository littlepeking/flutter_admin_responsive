import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:eh_flutter_framework/main/common/services/common/eh_rest_service.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_context_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_toast_helper.dart';
import 'package:eh_flutter_framework/main/common/utils/eh_util_helper.dart';
import 'package:eh_flutter_framework/main/components/home/components/dashboard/components/system_module/components/security/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    usernameController.text = 'jessica';
    passwordController.text = 'Laura';

    double loginBoxWidth = MediaQuery.of(context).size.width > 500
        ? 500
        : MediaQuery.of(context).size.width;
    double loginBoxHeight = MediaQuery.of(context).size.height > 700
        ? 700
        : MediaQuery.of(context).size.height;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width,
                  // child: Container(
                  //   color: Colors.black,
                  // ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/background_image.jpeg',
                      //#Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          blendMode: BlendMode.lighten,
                          filter: ImageFilter.blur(sigmaY: 70, sigmaX: 50),
                          child: Container(
                            height: loginBoxHeight * .9,
                            width: loginBoxWidth * .9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/enhantec.png",
                                  height: 70,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 0,
                                    bottom: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'SCM Execution Platform'.tr,
                                      style: TextStyle(
                                        letterSpacing:
                                            Get.locale == Locale('zh', 'CN')
                                                ? 4
                                                : 0,
                                        fontFamily: 'NotoSansSC',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                component(
                                  usernameController,
                                  Icons.account_circle_outlined,
                                  'Username'.tr,
                                  false,
                                  false,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                component(
                                  passwordController,
                                  Icons.lock_outline,
                                  'Password'.tr,
                                  true,
                                  false,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // RichText(
                                    //   text: TextSpan(
                                    //     text: 'Forgotten password!',
                                    //     style: TextStyle(
                                    //       color: Colors.white,
                                    //     ),
                                    //     recognizer: TapGestureRecognizer()
                                    //       ..onTap = () {
                                    //         HapticFeedback.lightImpact();
                                    //         // Fluttertoast.showToast(
                                    //         //   msg:
                                    //         //       'Forgotten password! button pressed',
                                    //         // );
                                    //       },
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 50),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (EHUtilHelper.isEmpty(
                                            usernameController.text) ||
                                        EHUtilHelper.isEmpty(
                                            passwordController.text)) {
                                      EHToastMessageHelper.showLoginErrorMessage(
                                          "username and password cannot be empty"
                                              .tr);
                                      return;
                                    }

                                    Response<Map<String, dynamic>> response =
                                        await EHRestService().postByServiceName<
                                                Map<String, dynamic>>(
                                            serviceName: '/auth',
                                            actionName: '/login',
                                            body: {
                                          'username': usernameController.text,
                                          'password': passwordController.text
                                        });

                                    await EHContextHelper.setString(
                                        "Authorization",
                                        response.headers['Authorization']![0]);

                                    await EHContextHelper.setString(
                                        'userInfo', jsonEncode(response.data!));

                                    await EHContextHelper.refreshPermissions();

                                    UserModel user =
                                        await EHContextHelper.getUserInfo();

                                    HapticFeedback.lightImpact();
                                    Get.offAllNamed('/');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: loginBoxWidth * .05,
                                    ),
                                    height: loginBoxHeight * .1,
                                    width: loginBoxWidth / 1.25,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Sign-In'.tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color: Colors.white)))),
                                    onPressed: () {
                                      var enLocale = Locale('en', 'US');
                                      var cnLocale = Locale('zh', 'CN');
                                      if (Get.locale == enLocale) {
                                        Get.updateLocale(cnLocale);
                                      } else {
                                        Get.updateLocale(enLocale);
                                      }
                                    },
                                    child: Text('changeLocale'.tr)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(TextEditingController controller, IconData icon,
      String hintText, bool isPassword, bool isEmail) {
    double width = MediaQuery.of(context).size.width > 500
        ? 500
        : MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height > 700
        ? 700
        : MediaQuery.of(context).size.height;
    Size size = Size(width, height);

    return Container(
      constraints: BoxConstraints(maxWidth: 500, maxHeight: 700),
      height: size.width / 10,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.7),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
