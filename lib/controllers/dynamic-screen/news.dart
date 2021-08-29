import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/news.dart';
import 'package:rhb_mobile_flutter/screens/news/detail.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class NewsController extends GetxController {
  Dio dio;
  List<News> news;
  int total;
  int currentIndex = 0;
  String imageAPI = RestApiController.publicImageAPI;
  GetStorage token = GetStorage('token');

  //Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    getNewsData();
    super.onInit();
  }

  Future getNewsData() async {
    try {
      var response = await api.dynamicContent(
        '/news?section=news&start=0&limit=5',
      );
      NewsResModel temp = NewsResModel.fromJson(response);
      news = temp.data.news;
      total = temp.data.count;
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

  void carouselChange(index) {
    currentIndex = index;
    update();
  }

  void detailNews({picture, description, url}) {
    Get.to(
      DetailNewsScreen(
        picture: picture,
        description: description,
        url: url,
      ),
    );
  }
}
