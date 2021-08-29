import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/main-tabs.dart';
import 'package:rhb_mobile_flutter/models/chat/chat.dart';
import 'package:rhb_mobile_flutter/screens/home/home.dart';
import 'package:rhb_mobile_flutter/screens/setting/setting.dart';
import 'package:rhb_mobile_flutter/screens/profile/user.dart';
import 'package:rhb_mobile_flutter/screens/chat/index.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainTabController extends GetxController {
  var currentIndex = 0.obs;
  int idSelected = 0;
  int categorySelected = 0;
  bool start = false;
  bool show = true;
  String initial;
  int unread = 0;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  Query<Map<String, dynamic>> chatRef;

  RestApiController api;
  UserController user;

  List<dynamic> tabs(String section) {
    if (section == 'route') {
      return [
        HomeScreen(),
        ProfileScreen(),
        ChatScreen(),
        SettingScreen(),
      ];
    } else if (section == 'icon') {
      return [
        'assets/icons/home-address-icon.svg',
        'assets/icons/profile-inactive-icon.svg',
        'assets/icons/livechat-inactive-icon.svg',
        'assets/icons/setting-inactive-icon.svg',
      ];
    } else {
      return [
        'Home',
        'Profile',
        'Livechat',
        'Setting',
      ];
    }
  }

  void changeTab(int index) {
    if (index == 2) {
      Get.to(ChatScreen());
      update();
    } else {
      currentIndex.value = index;
      update();
    }
  }

  void changeStart() {
    start = true;
    initial = null;
    update();
  }

  void toMain() async {
    api = Get.find<RestApiController>();
    user = Get.find<UserController>();

    chatRef = firebase
        .collection('chats')
        .doc(api.firebaseToken)
        .collection('message');
    Get.offAll(RehobotMainTabs());
  }

  void listMessage(messageList) async {
    List messages = messageList.map((element) {
      return Chat.fromJson({
        "user_id": element.data()["user_id"],
        "seenAt": element.data()["seenAt"],
        "sentAt": element.data()["sentAt"],
        "message": element.data()["message"],
      });
    }).toList();

    if (messages.length > 0) {
      for (int i = 0; i < messages.length; i++) {
        if ((messages[i].userId != user.userId) && messages[i].seenAt == "") {
          unread++;
        }
        if (i == messages.length - 1 &&
            (messages[i].userId != user.userId) &&
            messages[i].seenAt != "") {
          unread = 0;
        }
      }
    }
    // update(['chat-tab']);
  }

  void initialStart({int tab, String title, int categoryId, int sectionId}) {
    switch (title) {
      case 'Chat Notif':
        currentIndex.value = 0;
        initial = 'chat';
        break;
      case 'Job Request':
        currentIndex.value = tab;
        initial = 'job';
        break;
      case 'pasteur-message':
        currentIndex.value = tab;
        initial = title;
        idSelected = sectionId;
        break;
      case 'jadwal-ibadah':
        currentIndex.value = tab;
        initial = title;
        idSelected = sectionId;
        categorySelected = categoryId;
        break;
      default:
        currentIndex.value = 0;
        break;
    }
  }

  void backToHome() {
    currentIndex.value = 0;
    update();
  }
}
