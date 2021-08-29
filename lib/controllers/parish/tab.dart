import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/baptism.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/dedication.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/marriage.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/status.dart';

class ParishTabController extends GetxController {
  var currentIndex = 3.obs;

  List<dynamic> tabs(String section) {
    if (section == 'route') {
      return [
        BaptismParishScreen(),
        DedicationParishScreen(),
        MarriageParishScreen(),
        StatusParishScreen(),
      ];
    } else if (section == 'icon') {
      return [
        'assets/icons/pembaptisan-inactive-icon.svg',
        'assets/icons/penyerahan-anak--inactive-icon.svg',
        'assets/icons/bimbingan-pra-nikah--inactive-icon.svg',
        'assets/icons/status-saya--inactive-icon.svg',
      ];
    } else if (section == 'icon-active') {
      return [
        'assets/icons/pembaptisan-icon.svg',
        'assets/icons/penyerahan-anak-active-icon.svg',
        'assets/icons/bimbingan-pra-nikah-active-icon.svg',
        'assets/icons/status-saya-active-icon.svg',
      ];
    } else {
      return [
        'Pembaptisan',
        'Penyerahan Anak',
        'Bimbingan Pra Nikah & Pernikahan',
        'Status Saya',
      ];
    }
  }

  void changeTab(int index) {
    currentIndex.value = index;
    update();
  }
}
