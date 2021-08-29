import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/worship/worship.dart';
import 'package:rhb_mobile_flutter/models/worship/schedule.dart';
import 'package:rhb_mobile_flutter/screens/jadwal-ibadah/detail.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class WorshipController extends GetxController {
  String imageAPI = RestApiController.publicImageAPI;
  List<Section> worships;
  List<Schedule> list;
  int selectedCategoryId;
  int selectedSectionId;
  bool clickEvery = false;

  // Detail Screen
  String thumbnail;
  String title;
  String description;
  String url;

  // Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await getWorshipSections();
    super.onInit();
  }

  void changeEvery() {
    clickEvery = !clickEvery;
    update();
  }

  Future getWorshipSections() async {
    try {
      worships = await api.worshipCategories();
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().loginFailed();
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

  Future getListWorship({int categoryId, int sectionId}) async {
    try {
      List<Schedule> temp = await api.schedules('/${categoryId.toString()}');
      list = temp;
      selectedCategoryId = categoryId;
      selectedSectionId = sectionId;
      int sectionIdx = worships
          .map((e) {
            return e.id;
          })
          .toList()
          .indexWhere((element) => element == sectionId);
      int categoryIdx = worships[sectionIdx]
          .categories
          .map((e) {
            return e.id;
          })
          .toList()
          .indexWhere((element) => element == categoryId);
      thumbnail = worships[sectionIdx].categories[categoryIdx].thumbnail;
      title = worships[sectionIdx].categories[categoryIdx].title;
      description = worships[sectionIdx].categories[categoryIdx].description;
      url =
          "https://rehobot.org/jadwal-ibadah/$sectionId/${worships[sectionIdx].title.replaceAll(new RegExp(r"\s+\b|\b\s"), "-")}/$categoryId/${worships[sectionIdx].categories[categoryIdx].title.replaceAll(new RegExp(r"\s+\b|\b\s"), "-")}";
      Get.to(() => DetailWorshipScreen());
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().loginFailed();
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

  void checkItem({dynamic index}) async {
    try {
      clickEvery = false;
      List<Schedule> temp = [];

      if (index == null) {
        for (int idx = 0; idx < list.length; idx++) {
          if (list[idx].status == false) {
            temp.add(list[idx]);
          }
        }
      }

      List data = index != null
          ? [list[index].toJson()]
          : temp.map((e) => e.toJson()).toList();

      var response = await api.joinEvent(data: {
        "list": data,
      });

      if (response.statusCode == 200) {
        await getListWorship(
          categoryId: selectedCategoryId,
          sectionId: selectedSectionId,
        );
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().loginFailed();
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
