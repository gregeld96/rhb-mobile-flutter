import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/register/register.dart';
import 'package:rhb_mobile_flutter/screens/forgot-password/otp.dart';
import 'package:rhb_mobile_flutter/screens/introduction/introduction.dart';
import 'package:flutter/cupertino.dart';
import 'package:rhb_mobile_flutter/models/user/user.dart';
import 'package:rhb_mobile_flutter/services/onesignal.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class LoginController extends GetxController {
  var email;
  var password;
  var isLoginAllowed = false.obs;

  // Other Controller
  UserController userController = Get.find<UserController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    email = new TextEditingController();
    password = new TextEditingController();
    checkButton();
    super.onInit();
  }

  void checkButton() {
    if ((email.text.trim() != "") && (password.text.trim() != "")) {
      isLoginAllowed.value = true;
    } else {
      isLoginAllowed.value = false;
    }
  }

  void getForgotPasswordScreen() {
    Get.to(OTPScreen());
  }

  void getRegisterScreen() {
    Get.to(RegisterScreen());
    email.clear();
    password.clear();
  }

  Future login(context) async {
    try {
      CustomShowDialog().openLoading();

      var onesignal = await OneSignalSdk().getPermissionState();

      var form = {
        "inputUser": email.text,
        "password": password.text,
        "device_type": GetPlatform.isAndroid ? 1.toString() : 0.toString(),
        "onesignal_token": onesignal.userId,
      };

      var response = await api.userPost(
        endpoint: '/login',
        data: form,
      );

      UserResModel userData = UserResModel.fromJson(response.data);
      userController.resetData(userData);
      email.clear();
      password.clear();

      CustomShowDialog().closeLoading();

      Get.offAll(IntroductionScreen());
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();

      switch (e.statusCode) {
        case 422:
          CustomShowDialog().generalError(e.message);
          break;
        case 400:
          CustomShowDialog().loginFailed();
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }
}
