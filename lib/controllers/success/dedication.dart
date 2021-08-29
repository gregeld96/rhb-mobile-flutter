import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/hotline.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/models/user/children.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/parish-tab.dart';
import 'package:rhb_mobile_flutter/screens/success/success-dedication.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class SuccessDedicationController extends GetxController {
  Parish event;
  Hotline hotline;
  List<Child> selectedChildren;

  final UserController user = Get.find<UserController>();
  final ParishTabController tab = Get.find<ParishTabController>();
  RestApiController api = Get.find<RestApiController>();

  void toSuccessScreen({
    Parish eventData,
    List<Child> list,
  }) async {
    try {
      event = eventData;
      selectedChildren = list;
      var _hotlineData = await api.dynamicContent(
        '/hotline?section=dedication',
      );
      hotline = HotlineResModel.fromJson(_hotlineData).data;
      Get.off(SuccessDedicationScreen());
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
