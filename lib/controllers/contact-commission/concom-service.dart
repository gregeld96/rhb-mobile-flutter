import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/user/history.dart';
import 'package:rhb_mobile_flutter/models/user/request.dart';
import 'package:rhb_mobile_flutter/screens/contact-commission/detail-service.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class ServiceConcomController extends GetxController {
  List<UserRequest> listRequest;
  List<UserRequest> onGoingRequest;
  List<History> historyRequest;
  bool isLoading = false;
  String imageAPI = RestApiController.publicImageAPI;
  int start = 0;
  int totalData;
  UserRequest selectedRequest;
  String section;

  UserController user = Get.find<UserController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() {
    super.onInit();
  }

  void getData() async {
    try {
      listRequest = await api.userRequest(
        '/job-request/',
      );

      onGoingRequest = await api.userRequest(
        '/ongoing-request/',
      );

      HistoryResModel temp = await api.history(
        'request',
        '/job?limit=5&start=$start',
      );

      historyRequest = temp.data;
      totalData = temp.totalData;
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

  void detail(String category, int id) {
    int index = category == 'request'
        ? listRequest.indexWhere((element) => element.id == id)
        : onGoingRequest.indexWhere((element) => element.id == id);
    selectedRequest =
        category == 'request' ? listRequest[index] : onGoingRequest[index];
    section = category;
    update();
    Get.to(DetailServiceScreen());
  }

  void responseRequest(String section, bool value, int id) async {
    try {
      var response = await api.updateRequest(
        data: {
          "approval": value,
        },
        requestId: id.toString(),
      );

      if (response.statusCode == 200) {
        getData();
        if (section != 'home') {
          Get.back();
        }
      }
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

  void loadData() async {
    isLoading = true;
    update();
    await loadMoreHistory();
  }

  Future loadMoreHistory() async {
    try {
      if (historyRequest.length >= totalData) {
        isLoading = false;
        update();
      } else {
        start += 5;
        HistoryResModel temp = await api.history(
          'request',
          '/job?limit=5&start=$start',
        );
        historyRequest.addAll(temp.data);
        isLoading = false;
        update();
      }
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
