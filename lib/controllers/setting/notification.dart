import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/screens/setting/notification.dart';
import 'package:rhb_mobile_flutter/services/onesignal.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationSettingController extends GetxController {
  bool userSubscription;

  void onInit() {
    super.onInit();
  }

  void initial() {
    getOneSignalSubcriptionStatus();
    Get.to(NotificationScreen());
  }

  void getOneSignalSubcriptionStatus() async {
    var state = await OneSignalSdk().getPermissionState();
    userSubscription = state.pushDisabled;

    update();
  }

  void changeStatusPush() async {
    await OneSignal().disablePush(!userSubscription);
    userSubscription = !userSubscription;
    update();
  }
}
