import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/crisis-center.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class CriscenController extends GetxController {
  List<CrisisCenter> crisisCenter;
  String imageAPI = RestApiController.publicImageAPI;

  //Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await getCriscen();
    super.onInit();
  }

  Future getCriscen() async {
    try {
      var response = await api.dynamicContent('/criscen');
      CrisisCenterResModel temp = CrisisCenterResModel.fromJson(response);
      crisisCenter = temp.data;
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
