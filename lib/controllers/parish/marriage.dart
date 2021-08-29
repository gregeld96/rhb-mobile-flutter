import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/controllers/register/register_marriage.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class MarriageParishController extends GetxController {
  String bpnDate;
  TextEditingController marriageDate;
  List<Parish> listEvent;
  int selectedEvent;
  TextEditingController maleName;
  TextEditingController womanName;
  bool isValid = false;

  ParishTabController tab = Get.find<ParishTabController>();
  UserController user = Get.find<UserController>();
  RegisterMarriageController register = Get.put(RegisterMarriageController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    getListMarriage();
    super.onInit();
    ever(tab.currentIndex, (value) {
      if (tab.currentIndex.value == 2) {
        getListMarriage();
        update();
      }
    });
  }

  void getListMarriage() async {
    try {
      var response =
          await api.parishEventSpecific(endpoint: '/section/marriage');
      listEvent = ParishResModel.fromJson(response).data;
      marriageDate = new TextEditingController();
      maleName = new TextEditingController();
      womanName = new TextEditingController();
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

  void checkValue() {
    if ((maleName.text.trim() != "") &&
        (womanName.text.trim() != "") &&
        (bpnDate.trim() != "") &&
        (marriageDate.text.trim() != "")) {
      isValid = true;
    } else {
      isValid = false;
    }
    update();
  }

  void dateCheck() {
    var parseBpn = DateTime.parse(bpnDate);
    var parseMarriage =
        DateTime.parse(DateFormat().frontParse(marriageDate.text));

    dynamic difference = parseMarriage.difference(parseBpn).inDays + 1;

    if (difference < 90) {
      marriageDate = new TextEditingController();
      showDialog<void>(
        context: Get.context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Tidak di setujui'),
            content: Text(
                'Tanggal pernikahan kurang dari 3 bulan dari tanggal bimbingan pra nikah yang di pilih'),
            actions: [
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      );
      update();
    } else {
      checkValue();
    }
  }

  void dropDownChange(val) {
    bpnDate = val;
    marriageDate = new TextEditingController();
    checkValue();
  }

  void selectEvent() {
    int index = listEvent.indexWhere((element) => element.bpnDate == bpnDate);
    register.event = listEvent[index];
    register.marriageDate = marriageDate.text;
    register.toRegisterScreen();
  }
}
