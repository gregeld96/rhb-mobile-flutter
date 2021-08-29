import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom-service.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/contact-commission.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/contact-commission/detail-user.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class UserConcomController extends GetxController {
  List<ContactCommission> contactCommission;
  int indexSelected;
  String imageAPI = RestApiController.publicImageAPI;
  CarouselController carouselController = CarouselController();

  UserController user = Get.find<UserController>();
  ServiceConcomController service = Get.put(ServiceConcomController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    if (user.roles > 0) {
      service.getData();
    } else {
      await getConcom();
    }
    super.onInit();
  }

  void detailScreen(int index) {
    indexSelected = index;
    Get.to(ContactDetailScreen());
  }

  void increaseIndexPage() {
    carouselController.nextPage();
  }

  void decreaseIndexPage() {
    carouselController.previousPage();
  }

  void changePage(index) {
    indexSelected = index;
    update();
  }

  Future getConcom() async {
    try {
      var response = await api.dynamicContent('/concom');
      ContactComissionResModel temp =
          ContactComissionResModel.fromJson(response);
      contactCommission = temp.data;
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
