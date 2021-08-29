import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/forgot-password/forgot-password.dart';
import 'package:rhb_mobile_flutter/screens/success/success.dart';
import 'package:rhb_mobile_flutter/screens/login/login.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class ForgotPasswordController extends GetxController {
  List otp = [].obs;
  var phoneNumber;
  var password;
  var confirmPassword;
  var isComplete = true.obs;
  var indexPage = 0.obs;
  var secure;
  var endTime = 0.obs;

  RestApiController api = Get.find<RestApiController>();

  void onInit() {
    otp = List.generate(4, (index) => TextEditingController());
    phoneNumber = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    checkButton('otp');
    super.onInit();
  }

  void startCountDown() {
    endTime.value = DateTime.now().millisecondsSinceEpoch + 1000 * 10;
  }

  void getOTP() {
    reSendOTP();
  }

  void checkButton(screen) {
    if (screen == 'otp') {
      switch (indexPage.value) {
        case 0:
          if (phoneNumber.text.trim() == "") {
            isComplete.value = false;
            return;
          } else {
            isComplete.value = true;
          }
          break;
        case 1:
          for (int i = 0; i < otp.length; i++) {
            if (otp[i].text.trim() == "") {
              isComplete.value = false;
              return;
            }
            if (i == otp.length - 1 && otp[i].text.trim() != "") {
              isComplete.value = true;
            }
          }
          break;
        default:
      }
    } else {
      if ((password.text.trim() == "") || (confirmPassword.text.trim() == "")) {
        isComplete.value = false;
      } else {
        isComplete.value = true;
      }
    }
  }

  void nextPage() {
    if (indexPage.value < 1) {
      submitPhone();
    } else {
      verifyOTP();
    }
  }

  void secureNumber() {
    secure = phoneNumber.text.replaceAll(RegExp(r'.(?=.{3})'), '*');
  }

  void getBack() {
    if (indexPage.value != 0) {
      indexPage.value--;
      checkButton('otp');
    } else {
      Get.back();
    }
  }

  void submitPhone() async {
    try {
      var response = await api.userPost(
        endpoint: '/otp/request/',
        data: {
          "phone_number": phoneNumber.text,
        },
      );

      if (response.statusCode == 200) {
        indexPage.value++;
        checkButton('otp');
        startCountDown();
        secureNumber();
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }

  void reSendOTP() async {
    var response = await api.userPost(endpoint: '/otp/request/', data: {
      "phone_number": phoneNumber.text,
    });
    if (response.statusCode == 200) {
      startCountDown();
    }
  }

  void verifyOTP() async {
    try {
      List otpNumbers = [];

      otp.forEach((element) {
        otpNumbers.add(element.text);
      });

      String stringOTP = otpNumbers.join("");

      var response = await api.userPost(
        endpoint: '/otp/verification/',
        data: {
          "phone_number": phoneNumber.text,
          "otp": stringOTP,
        },
      );

      if (response.statusCode == 200) {
        indexPage.value = 0;
        checkButton('forgot');
        Get.to(ForgotPasswordScreen());
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          switch (e.message) {
            case 'Connection Timeout':
              CustomShowDialog().generalError(e.message);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  void submitPassword() async {
    try {
      var response =
          await api.updateProfile(endpoint: '/forgot-password', data: {
        "phone_number": phoneNumber.text,
        "password": password.text,
      });
      if (response.statusCode == 200) {
        password.clear();
        confirmPassword.clear();
        phoneNumber.clear();
        otp.clear();
        Get.to(
          SuccessScreen(
            imageName: 'password-updated-img.png',
            onPress: () {
              Get.off(LoginScreen());
            },
            title:
                'Password Anda telah berhasil \n diperbaharui. Terima Kasih.',
            description: '',
            titleSize: 18,
            imagePadding: 50,
            buttonTitle: 'SIGN IN',
          ),
        );
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          switch (e.message) {
            case 'Connection Timeout':
              CustomShowDialog().generalError(e.message);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }
}
