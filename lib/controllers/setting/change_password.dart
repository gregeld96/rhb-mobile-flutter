import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/setting/change_password.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class ChangePasswordController extends GetxController {
  var currentPassword;
  var password;
  var confirmPassword;
  var isComplete = true.obs;
  var indexPage = 0.obs;

  //Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() {
    super.onInit();
  }

  void initial() {
    currentPassword = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    isComplete.value = true;
    indexPage.value = 0;
    Get.to(ChangePasswordScreen());
    update();
  }

  void nextPage() {
    if (indexPage.value < 1) {
      verifyPassword();
    } else {
      submitPassword();
    }
  }

  void checkButton(screen) {
    if (screen == 'input') {
      if (currentPassword.text.trim() == "") {
        isComplete.value = false;
        return;
      } else {
        isComplete.value = true;
      }
    } else {
      if ((password.text.trim() == "") || (confirmPassword.text.trim() == "")) {
        isComplete.value = false;
      } else {
        isComplete.value = true;
      }
    }
  }

  void getBack() {
    if (indexPage.value != 0) {
      indexPage.value--;
      checkButton('input');
    } else {
      Get.back();
    }
  }

  void verifyPassword() async {
    try {
      CustomShowDialog().openLoading();

      var response = await api.updateProfile(
        endpoint: '/verify-password',
        data: {
          "password": currentPassword.text,
        },
      );

      if (response.statusCode == 200) {
        CustomShowDialog().closeLoading();
        indexPage.value++;
        update();
      }
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();

      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          ErrorController().tokenError(error: e);
          break;
        default:
          switch (e.message) {
            case 'jwt expired':
              ErrorController().tokenError(error: e);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  void submitPassword() async {
    try {
      CustomShowDialog().openLoading();

      var response = await api.updateProfile(
        endpoint: '/change-password',
        data: {
          "password": password.text,
        },
      );

      if (response.statusCode == 200) {
        CustomShowDialog().closeLoading();

        Get.dialog(
          CupertinoAlertDialog(
            title: Text('Berhasil diubah'),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RehobotGeneralText(
                title: 'Kamu berhasil merubah password akun rehobot.',
                alignment: Alignment.center,
                alignText: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            actions: [
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();

      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          ErrorController().tokenError(error: e);
          break;
        default:
          switch (e.message) {
            case 'jwt expired':
              ErrorController().tokenError(error: e);
              break;
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
