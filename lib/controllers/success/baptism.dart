import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/hotline.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/parish-tab.dart';
import 'package:rhb_mobile_flutter/screens/success/success-baptism.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class SuccessBaptismController extends GetxController {
  Parish event;
  Hotline hotline;
  PickFile file;

  final UserController user = Get.find<UserController>();
  final ParishTabController tab = Get.find<ParishTabController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() {
    super.onInit();
  }

  void toSuccessScreen({
    Parish eventData,
    PickFile fileData,
  }) async {
    try {
      event = eventData;
      file = fileData;
      var _hotlineData = await api.dynamicContent('/hotline?section=baptism');
      hotline = HotlineResModel.fromJson(_hotlineData).data;
      await user.resetProfile();
      Get.off(SuccessBaptismScreen());
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

  void back() {
    tab.changeTab(3);
    Get.off(ParishTab());
  }
}
