import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/home.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/hotline.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/testimonial.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class HomePageController extends GetxController {
  Hotline hotline;
  List<Schedule> home;
  List<Testimony> testimony;
  String imageAPI = RestApiController.publicImageAPI;
  List<Definition> definition = [
    Definition.fromJson({
      "alphabet": "H",
      "description": "Humility before God",
    }),
    Definition.fromJson({
      "alphabet": "O",
      "description": "Obedience to God\'s command",
    }),
    Definition.fromJson({
      "alphabet": "M",
      "description": "Magnifiying God in our daily life",
    }),
    Definition.fromJson({
      "alphabet": "E",
      "description": "Encouraging others to grow",
    })
  ];

  //Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await initial();
    super.onInit();
  }

  Future initial() async {
    try {
      var hotlineRes = await api.dynamicContent('/hotline?section=home');
      var homeRes = await api.dynamicContent('/home');
      var testiRes = await api.dynamicContent('/testimonials?section=home');
      hotline = HotlineResModel.fromJson(hotlineRes).data;
      home = HomeResModel.fromJson(homeRes).data;
      testimony = TestimonyResModel.fromJson(testiRes).data;
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
          CustomShowDialog().staticError();
      }
    }
  }
}

class Definition {
  String alphabet;
  String description;

  Definition({this.alphabet, this.description});

  Definition.fromJson(Map<String, dynamic> json) {
    alphabet = json['alphabet'];
    description = json['description'];
  }
}
