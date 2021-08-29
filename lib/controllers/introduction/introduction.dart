import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/introduction.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_storage/get_storage.dart';

class IntroductionController extends GetxController {
  List<Intro> intro;
  var indexPage = 0.obs;
  List<Widget> imageNetwork;
  GetStorage user = GetStorage('user');

  String imageAPI = RestApiController.publicImageAPI;

  //Other Controller
  RestApiController api = Get.find<RestApiController>();
  MainTabController tab = Get.find<MainTabController>();

  void onInit() async {
    await fetchData();
    fetchImage();
    super.onInit();
  }

  void fetchImage() {
    imageNetwork = List.generate(intro.length, (index) {
      return CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: imageAPI + '/flash-page/${intro[index].image}',
      );
    });
  }

  String titlePage() {
    switch (indexPage.value) {
      case 0:
        return '${intro[indexPage.value].title}\n${user.read('fullName')}!';
        break;
      case 1:
        return '${intro[indexPage.value].title}';
        break;
      case 2:
        return '${intro[indexPage.value].title}';
        break;
      case 3:
        return '${intro[indexPage.value].title}';
        break;
      default:
        return '';
    }
  }

  String buttonText() {
    if (indexPage.value < intro.length - 1) {
      return 'NEXT';
    } else {
      return 'FINISH';
    }
  }

  increment() {
    if (indexPage.value == intro.length - 1) {
      indexPage.value = 0;
      tab.toMain();
    } else {
      indexPage.value++;
      update();
    }
  }

  Future fetchData() async {
    var response = await api.dynamicContent('/intro');
    IntroductionResModel temp = IntroductionResModel.fromJson(response);
    intro = temp.data;
    update();
  }
}
