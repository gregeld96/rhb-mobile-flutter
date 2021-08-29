import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'dart:async';
import 'package:rhb_mobile_flutter/screens/login/login.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  int _duration = 2000;
  GetStorage user = GetStorage('user');
  GetStorage token = GetStorage('token');

  UserController userController = Get.put(UserController());
  MainTabController tab = Get.find<MainTabController>();

  @override
  void onInit() {
    redirectToLoginScreen();
    super.onInit();
  }

  userLoggedIn() async {
    if ((user.read('fullName') != '' && token.read('access') != '') &&
        (user.read('fullName') != null && token.read('access') != null)) {
      await userController.getPersonalData();
      tab.toMain();
    } else {
      Get.off(LoginScreen());
    }
  }

  void redirectToLoginScreen() {
    Timer(Duration(milliseconds: _duration), () {
      userLoggedIn();
    });
  }
}
