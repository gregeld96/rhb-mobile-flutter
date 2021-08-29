import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/hotline.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/parish-tab.dart';
import 'package:rhb_mobile_flutter/screens/success/success-marriage.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class SuccessMarriageController extends GetxController {
  Hotline hotline;

  final UserController user = Get.find<UserController>();
  final ParishTabController tab = Get.find<ParishTabController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() {
    super.onInit();
  }

  List<String> documents() {
    return [
      'Surat pernyataan persetujuan orang tua/wali (sebelum BPN)',
      'Surat kedutaan(bagi WNA)',
      'Foto Berpasangan 4x6',
      'Surat kelurahan N1-N4',
      'Passport(bagi WNA)',
      'Surat ganti nama(bila ada)',
      'Surat pernyataan belum menikah\n(form tersedia di sekretariat dan harus bermaterai)',
    ];
  }

  void toSuccessScreen() async {
    try {
      var _hotlineData = await api.dynamicContent('/hotline?section=marriage');
      hotline = HotlineResModel.fromJson(_hotlineData).data;
      await user.resetProfile();
      Get.off(SuccessMarriageScreen());
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
