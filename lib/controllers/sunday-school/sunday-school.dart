import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/testimonial.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/video.dart';
import 'package:rhb_mobile_flutter/controllers/user/children.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/sunday-school/sunday-school.dart';
import 'package:rhb_mobile_flutter/screens/profile/child.dart';
import 'package:rhb_mobile_flutter/screens/sunday-school/register_sunday_school.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class SundaySchoolController extends GetxController {
  List<SundaySchool> events;
  List<Testimony> testimony;
  List<Video> video;
  var selectedEvent = 0.obs;
  String imageAPI = RestApiController.publicImageAPI;

  //Other Controller
  UserChildController childrenController = Get.put(UserChildController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    initial();
    super.onInit();
    ever(childrenController.children, (value) {
      print(childrenController.children);
      update();
    });
  }

  void initial() async {
    try {
      var testiRes = await api.dynamicContent('/testimonials?section=sunday');
      testimony = TestimonyResModel.fromJson(testiRes).data;
      var videoRes = await api.dynamicContent('/video?section=sunday');
      video = VideoResModel.fromJson(videoRes).data;
      var schedulesRes = await api.fetchSundaySchool('/schedule');
      events = SundaySchoolResModel.fromJson(schedulesRes).data;
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

  void getSchedule() async {
    try {
      var schedulesRes = await api.fetchSundaySchool('/schedule');
      events = SundaySchoolResModel.fromJson(schedulesRes).data;
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

  void getBack(context) async {
    Get.back();
  }

  void registerEvent(int id) async {
    selectedEvent.value = id;
    var data = await Get.to(RegisterSundaySchool());
    if (data != null) {
      getSchedule();
    }
  }

  void profileChild({int id, int index}) async {
    childrenController.profileChildTap(id, index);
    await Get.to(ProfileChildScreen());
    update();
  }
}
