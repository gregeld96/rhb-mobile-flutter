import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/controllers/register/register_dedication.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class DedicationParishController extends GetxController {
  List<Parish> listEvent;
  int selectedEvent;

  //Other Controller
  ParishTabController tab = Get.find<ParishTabController>();
  RegisterDedicationController register =
      Get.put(RegisterDedicationController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    getListDedication();
    super.onInit();
    ever(tab.currentIndex, (value) {
      if (tab.currentIndex.value == 1) {
        getListDedication();
        update();
      }
    });
  }

  void getListDedication() async {
    try {
      var response =
          await api.parishEventSpecific(endpoint: '/section/dedication');
      listEvent = ParishResModel.fromJson(response).data;
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

  void selectEvent(int id) {
    int index = listEvent.indexWhere((element) => element.id == id);
    register.event = listEvent[index];
    register.toRegisterScreen();
  }
}
