import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rhb_mobile_flutter/config/setting.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/screens/chat/index.dart';
import 'package:rhb_mobile_flutter/screens/home/home.dart';

String oneSignalId = GlobalSetting().oneSignalId;

class OneSignalSdk extends GetxController {
  bool oktest = false;
  final initOnsignal = OneSignal.shared.setAppId(oneSignalId);
  MainTabController tab = Get.put(MainTabController());

  Future<void> promtUser() async {
    if (Platform.isAndroid) {
      return;
    }
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  Future<OSDeviceState> getPermissionState() {
    return OneSignal.shared.getDeviceState();
  }

  void initialize() {
    // OneSignal.shared.setNotificationWillShowInForegroundHandler(
    //     (OSNotificationReceivedEvent notification) {});
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      switch (result.notification.title) {
        case 'Chat Notif':
          if (tab.start) {
            print('masuk');
            Get.to(ChatScreen());
          } else {
            tab.initialStart(
              tab: 0,
              title: result.notification.title,
            );
          }
          break;
        case 'Job Request':
          tab.initialStart(
            tab: 0,
            title: result.notification.title,
          );
          break;
        default:
          tab.initialStart(
            tab: 0,
            title: result.notification.title,
          );
      }
    });
  }
}
