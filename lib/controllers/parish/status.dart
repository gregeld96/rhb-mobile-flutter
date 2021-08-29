import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class StatusParishController extends GetxController {
  List<ParishStatus> listStatus;
  GetStorage token = GetStorage('token');

  UserController user = Get.find<UserController>();
  ParishTabController tab = Get.find<ParishTabController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await getListParishStatus();
    super.onInit();
    ever(tab.currentIndex, (value) {
      if (tab.currentIndex.value == 3) {
        getListParishStatus();
        update();
      }
    });
  }

  Future getListParishStatus() async {
    try {
      var response = await api.parishEventSpecific(
        endpoint: '/list?user_id=${user.userId}',
      );
      listStatus = ParishStatusResModel.fromJson(response).data;
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
