import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/giving.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class GivingController extends GetxController {
  Giving giving;
  String imageAPI = RestApiController.publicImageAPI;

  //Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    getGivingData();
    super.onInit();
  }

  Future getGivingData() async {
    try {
      var response = await api.dynamicContent('/giving');
      GivingResModel temp = GivingResModel.fromJson(response);
      giving = temp.data;
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
}
