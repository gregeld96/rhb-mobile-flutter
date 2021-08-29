import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/screens/view_image/view.dart';

class ViewImageController extends GetxController {
  void imagePage(filePath, ext) {
    Get.to(ViewImageScreen(
      file: filePath,
      ext: ext,
    ));
  }

  void back() {
    Get.back();
  }
}
