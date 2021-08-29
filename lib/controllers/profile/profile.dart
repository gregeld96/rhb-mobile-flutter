import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/user/history.dart';
import 'package:rhb_mobile_flutter/screens/history/user-profile.dart';
import 'dart:async';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  String imageAPI = RestApiController.publicImageAPI;
  int start = 0;
  int totalData;
  List<History> history;

  UserController user = Get.put(UserController());
  MainTabController tab = Get.find<MainTabController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await getUserHistoryEvents();
    super.onInit();
    ever(user.profilePic, (value) {
      update();
    });
    ever(user.fullName, (value) {
      update();
    });
    ever(tab.currentIndex, (value) async {
      if (tab.currentIndex.value == 1) {
        await getUserHistoryEvents();
        update();
      }
    });
  }

  Future getUserHistoryEvents() async {
    try {
      HistoryResModel temp = await api.history(
        'profile',
        '/history?user_id=${user.userId.toString()}&limit=5&start=$start',
      );
      history = temp.data;
      totalData = temp.totalData;
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
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

  void loadData() async {
    isLoading = true;
    update();
    await loadMoreHistory();
  }

  Future loadMoreHistory() async {
    try {
      if (history.length >= totalData) {
        isLoading = false;
        update();
      } else {
        start += 4;
        HistoryResModel temp = await api.history(
          'profile',
          '/history?user_id=${user.userId.toString()}&limit=5&start=$start',
        );
        history.addAll(temp.data);
        isLoading = false;
        update();
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
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

  void goHistoryUser() {
    Get.to(ProfileHistoryScreen());
  }
}
