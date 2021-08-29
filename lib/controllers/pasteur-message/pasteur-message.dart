import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/pasteur-message.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/pasteur-message/detail.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class PasteurMessageController extends GetxController {
  List<PasteurMessage> pasteurMessages;
  int start = 0;
  int total;
  int currentTotal = 4;
  bool isLoading = false;

  //Other Controller
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await getPasteurMessage();
    super.onInit();
  }

  void messageScreen({int id}) async {
    try {
      var response = await api.dynamicContent(
        '/shepherd-letters/${id.toString()}',
      );
      PasteurMessageResModel temp = PasteurMessageResModel.fromJson(response);

      String editedTitle =
          temp.data[0].title.replaceAll(new RegExp(r"\s+\b|\b\s"), "-");

      Get.to(
        DetailMessageScreen(
          description: temp.data[0].description,
          title: temp.data[0].title,
          published: temp.data[0].publishedAt,
          url:
              "https://rehobot.org/pasteur-message/${temp.data[0].id}/$editedTitle",
        ),
      );
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
    await loadMoreMessage();
  }

  Future loadMoreMessage() async {
    if (currentTotal >= total) {
      isLoading = false;
      update();
    } else {
      start += 4;
      currentTotal += 4;
      var response = await api.dynamicContent(
          '/shepherd-letters?limit=4&start=${start.toString()}');
      PasteurMessageResModel temp = PasteurMessageResModel.fromJson(response);
      pasteurMessages.addAll(temp.data);
      isLoading = false;
      update();
    }
  }

  Future getPasteurMessage() async {
    var response = await api
        .dynamicContent('/shepherd-letters?limit=4&start=${start.toString()}');
    PasteurMessageResModel temp = PasteurMessageResModel.fromJson(response);
    pasteurMessages = temp.data;
    total = temp.total;
    update();
  }
}
