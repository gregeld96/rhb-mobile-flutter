import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/address/address.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/register-payload.dart';
import 'package:rhb_mobile_flutter/models/user/user.dart';
import 'package:rhb_mobile_flutter/screens/setting/update_data.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class UpdateDataController extends GetxController {
  List<TextEditingController> userEdit;
  List<TextEditingController> emergency;
  final formUser = GlobalKey<FormState>();
  final formOther = GlobalKey<FormState>();
  var formData;
  var isComplete = true;

  //Other Controller
  final AddressController address = Get.put(AddressController());
  final UserController user = Get.find<UserController>();
  final RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    address.createListAddress(2);
    super.onInit();
  }

  Future resetData({Emergency data}) async {
    userEdit = List.generate(9, (inputField) => TextEditingController());
    emergency = List.generate(6, (inputField) => TextEditingController());
    await address.getProvince();
    await address.addressFill('personal', 'province', user.address.province);
    await address.addressFill('personal', 'city', user.address.city);
    await address.addressFill('personal', 'district', user.address.district);
    await address.addressFill(
        'personal', 'subdistrict', user.address.subdistrict);
    await address.addressFill(
      'personal',
      'codePost',
      user.address.postCode.isNumericOnly ? user.address.postCode : null,
    );
    if (data != null) {
      await address.addressFill('other', 'province', data.address.province);
      await address.addressFill('other', 'city', data.address.city);
      await address.addressFill('other', 'district', data.address.district);
      await address.addressFill(
          'other', 'subdistrict', data.address.subdistrict);
      await address.addressFill(
        'other',
        'codePost',
        data.address.postCode,
      );
    }
  }

  void toUpdateDataScreen() async {
    Emergency temp = await api.userEmergencyData();
    await resetData(data: temp);
    userEdit[0].text = user.fullName.value;
    userEdit[1].text = user.birthPlace;
    userEdit[2].text = DateFormat().backToFront(user.userBirthday.value);
    userEdit[3].text = user.gender;
    userEdit[4].text = user.occupation;
    userEdit[5].text = user.address.address;
    userEdit[6].text = user.address.area;
    userEdit[7].text = user.phoneNumber.value;
    userEdit[8].text = user.email.value;
    emergency[0].text = temp != null ? temp.fullName : '';
    emergency[1].text = temp != null ? temp.relations : '';
    emergency[2].text = temp != null ? temp.gender : '';
    emergency[3].text = temp != null ? temp.phoneNumber : '';
    emergency[4].text = temp != null ? temp.address.address : '';
    emergency[5].text = temp != null ? temp.address.area : '';
    checkButton();
    Get.to(UpdateDataScreen());
  }

  void checkButton() {
    bool userResponse = address.addressCheck('personal');
    bool otherResponse = address.addressCheck('other');

    for (int i = 0; i < userEdit.length; i++) {
      if (userEdit[i].text.trim() == "") {
        isComplete = false;
        update();
        return;
      }

      if (!userResponse) {
        isComplete = false;
        update();
        return;
      }

      if (i == userEdit.length - 1 &&
          userEdit[i].text.trim() != "" &&
          userResponse) {
        isComplete = true;
      }
    }

    for (int i = 0; i < emergency.length; i++) {
      if (emergency[i].text.trim() == "") {
        isComplete = false;
        update();
        return;
      }

      if (!otherResponse) {
        isComplete = false;
        update();
        return;
      }

      if (i == emergency.length - 1 &&
          emergency[i].text.trim() != "" &&
          otherResponse) {
        isComplete = true;
        update();
      }
    }
    update();
  }

  void dropdownChange(
      {@required String section,
      @required String category,
      @required String value,
      index = 0}) async {
    switch (category) {
      case 'gender':
        switch (section) {
          case 'personal':
            userEdit[3].text = value;
            break;
          default:
            emergency[2].text = value;
            break;
        }
        break;
      case 'occupation':
        if (section == 'personal') userEdit[4].text = value;
        break;
      default:
        await address.addressFill(section, category, value);
        break;
    }
    checkButton();
  }

  void submit() async {
    try {
      CustomShowDialog().openLoading();

      var response = await api.updateProfile(
        endpoint: '/update-data',
        data: {
          "user": {
            "full_name": userEdit[0].text,
            "birth_place": userEdit[1].text,
            "birth_of_date": userEdit[2].text,
            "gender": userEdit[3].text,
            "occupation": userEdit[4].text,
            "email": userEdit[8].text,
            "phone_number": userEdit[7].text,
            "address": {
              "address": userEdit[5].text,
              "province": address.address[0].province,
              "city": address.address[0].city,
              "district": address.address[0].district,
              "subdistrict": address.address[0].subdistrict,
              "postCode": address.address[0].codePost,
              "area": userEdit[6].text,
            },
          },
          "emergency": {
            "full_name": emergency[0].text,
            "relationship": emergency[1].text,
            "gender": emergency[2].text,
            "address": {
              "address": emergency[4].text,
              "province": address.address[1].province,
              "city": address.address[1].city,
              "district": address.address[1].district,
              "subdistrict": address.address[1].subdistrict,
              "postCode": address.address[1].codePost,
              "area": emergency[5].text,
            },
            "phone_number": emergency[3].text
          },
        },
      );

      UserResModel temp = UserResModel.fromJson(response.data);

      if (response.statusCode == 200) {
        CustomShowDialog().closeLoading();

        Get.dialog(
          CupertinoAlertDialog(
            title: Text('Berhasil diubah'),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: RehobotGeneralText(
                title: 'Kamu berhasil merubah data akun rehobot.',
                alignment: Alignment.center,
                alignText: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            actions: [
              Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () async {
                    await user.resetData(temp);
                    Get.back();
                    Get.back();
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
          ),
        );
      }
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();

      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          ErrorController().tokenError(error: e);
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
