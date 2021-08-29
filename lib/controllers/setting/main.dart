import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/controllers/setting/change_password.dart';
import 'package:rhb_mobile_flutter/controllers/setting/notification.dart';
import 'package:rhb_mobile_flutter/controllers/setting/update_data.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/help.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/login/login.dart';
import 'package:rhb_mobile_flutter/screens/setting/help.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class SettingController extends GetxController {
  Help help;
  GetStorage user = GetStorage('user');
  GetStorage token = GetStorage('token');

  //Other Controller
  RestApiController api = Get.find<RestApiController>();
  ChangePasswordController change = Get.put(ChangePasswordController());
  UpdateDataController updateData = Get.put(UpdateDataController());
  NotificationSettingController notif =
      Get.put(NotificationSettingController());
  MainTabController tab = Get.find<MainTabController>();

  List<SettingDefinition> list = [
    SettingDefinition.fromJson({
      "icon": 'assets/icons/change-password-icon.svg',
      "name": 'Change Password',
      "function": () {}
    }),
    SettingDefinition.fromJson({
      "icon": 'assets/icons/notification-and-sound-icon.svg',
      "name": 'Notifikasi dan Suara',
    }),
    SettingDefinition.fromJson({
      "icon": 'assets/icons/pencil-edit-icon.svg',
      "name": 'Edit Data',
    }),
    SettingDefinition.fromJson({
      "icon": 'assets/icons/help-icon.svg',
      "name": 'Help',
    }),
    SettingDefinition.fromJson({
      "icon": 'assets/icons/logout-icon.svg',
      "name": 'Log Out',
    }),
  ];

  functionList(int index) {
    switch (index) {
      case 0:
        return () {
          change.initial();
        };
        break;
      case 1:
        return () {
          notif.initial();
        };
        break;
      case 2:
        return () {
          updateData.toUpdateDataScreen();
        };
        break;
      case 3:
        return () {
          toHelpScreen();
        };
        break;
      case 4:
        return () {
          logout();
        };
        break;
      default:
    }
  }

  void onInit() async {
    getHelpData();
    super.onInit();
  }

  void toHelpScreen() {
    Get.to(HelpScreen(
      title: help.title,
      description: help.description,
    ));
  }

  void getHelpData() async {
    try {
      var response = await api.dynamicContent('/help');
      HelpResModel temp = HelpResModel.fromJson(response);
      help = temp.help;
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().generalError(e.message);
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

  void confirmationPop() {
    AlertDialog logout = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Center(
        child: RehobotGeneralText(
          fontSize: 18,
          title: 'Logout',
          fontWeight: FontWeight.bold,
          alignText: TextAlign.center,
          color: Colors.black,
          alignment: Alignment.center,
        ),
      ),
      content: Container(
        height: 25,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: RehobotGeneralText(
          fontSize: 14,
          title: 'Are sure want to logout ?',
          fontWeight: FontWeight.normal,
          alignText: TextAlign.center,
          color: Colors.black,
          alignment: Alignment.center,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RehobotButton().roundedButton(
              radius: 15,
              title: 'No',
              context: Get.context,
              height: 5,
              widthDivider: Get.context.size.width / 20,
              textColor: Colors.black,
              buttonColor: Colors.white,
              onPressed: () {
                Get.back();
              },
            ),
            RehobotButton().roundedButton(
              radius: 15,
              title: 'Yes',
              context: Get.context,
              height: 5,
              widthDivider: Get.context.size.width / 20,
              textColor: Colors.black,
              buttonColor: Colors.white,
              onPressed: () async {
                Get.back();
                CustomShowDialog().openLoading();
                await api.updateProfile(
                  endpoint: '/logout',
                  data: null,
                );
                user.erase();
                token.erase();
                CustomShowDialog().closeLoading();
                Get.offAll(LoginScreen());
              },
            )
          ],
        ),
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        return logout;
      },
    );
  }

  void logout() async {
    confirmationPop();
  }
}

class SettingDefinition {
  String icon;
  String name;

  SettingDefinition({this.icon, this.name});

  SettingDefinition.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    name = json['name'];
  }
}
