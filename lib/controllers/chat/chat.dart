import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/chat/chat.dart';
import 'package:rhb_mobile_flutter/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  TextEditingController chat;
  ScrollController scroll = new ScrollController(
    initialScrollOffset: Get.context.height,
  );
  List messages;
  List timeMessage;
  List timeSeen;
  int limit = 30;
  double matricPixel = 0;
  bool isIncreaseLimit = false;
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  Query<Map<String, dynamic>> chatRef;
  bool confirm = false;

  UserController user = Get.find<UserController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    initial();
    super.onInit();
  }

  void initial() async {
    try {
      chat = new TextEditingController();

      if (api.firebaseToken == '') {
        UserResModel data = await api.userFirebase();
        await user.resetData(data);
      }

      chatRef = firebase
          .collection('chats')
          .doc(api.firebaseToken)
          .collection('message');

      update(['general']);
    } catch (e) {
      print('sini');
      print(e);
    }
  }

  void sendMessage() async {
    try {
      var response = await api.sentMessage(data: {
        "message": chat.text,
      });

      if (response.statusCode == 200) {
        chat.text = '';
        update(['send', 'chat-list']);
      }
    } catch (e) {
      print(e);
    }
  }

  void checkText() {
    if (chat.text.trim() != '') {
      confirm = true;
      update(['send']);
    } else {
      confirm = false;
      update(['send']);
    }
  }

  void listMessage(messageList) async {
    messages = messageList.map((element) {
      return Chat.fromJson({
        "user_id": element.data()["user_id"],
        "seenAt": element.data()["seenAt"],
        "sentAt": element.data()["sentAt"],
        "message": element.data()["message"],
      });
    }).toList();
    timeMessage = messageList.map((e) {
      return DateFormat("dd MMMM y").format(
        DateTime.fromMillisecondsSinceEpoch(e.data()["sentAt"]),
      );
    }).toList();
    timeSeen = messageList.map((e) {
      return e.data()["seenAt"] != ''
          ? DateFormat("jm").format(
              DateTime.fromMillisecondsSinceEpoch(e.data()["seenAt"]),
            )
          : '';
    }).toList();
    if ((messages[messages.length - 1].userId != user.userId) &&
        messages.length > 0) {
      seenMessage();
    }
  }

  Future<void> increaseLimitMessage(double matricPix) async {
    limit += 10;
    matricPixel = matricPix;
    isIncreaseLimit = true;
    update();
  }

  void enableAutoScroll({bool isUpdate = false}) {
    if (isUpdate) {
      isIncreaseLimit = false;
    } else {
      isIncreaseLimit = false;
    }
  }

  void seenMessage() async {
    try {
      api.updatedSeenChat();
    } catch (e) {
      print(e);
    }
  }
}
