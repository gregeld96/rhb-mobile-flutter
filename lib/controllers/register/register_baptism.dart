import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/address/address.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/success/baptism.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:rhb_mobile_flutter/screens/register/register_baptism.dart';
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:dio/src/form_data.dart' as form;
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class RegisterBaptismController extends GetxController {
  var indexPage = 0;
  var maxPage = 1;
  List<TextEditingController> userEdit;
  PickFile file;
  Parish event;
  var isComplete = false;
  var validInfo = false;
  var formData;

  // Other Controller
  final AddressController address = Get.put(AddressController());
  final UserController user = Get.find<UserController>();
  final SuccessBaptismController success = Get.put(SuccessBaptismController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    address.createListAddress(1);
    super.onInit();
  }

  Future resetData() async {
    userEdit = List.generate(9, (inputField) => TextEditingController());
    await address.getProvince();
    await address.addressFill('personal', 'province', user.address.province);
    await address.addressFill('personal', 'city', user.address.city);
    await address.addressFill('personal', 'district', user.address.district);
    await address.addressFill(
        'personal', 'subdistrict', user.address.subdistrict);
    await address.addressFill('personal', 'codePost', user.address.postCode);
  }

  void toRegisterScreen() async {
    await resetData();
    userEdit[0].text = user.fullName.value;
    userEdit[1].text = user.birthPlace;
    userEdit[2].text = DateFormat().backToFront(user.userBirthday.value);
    userEdit[3].text = user.gender;
    userEdit[4].text = user.occupation;
    userEdit[5].text = user.address.address;
    userEdit[6].text = user.address.area;
    userEdit[7].text = user.phoneNumber.value;
    userEdit[8].text = user.email.value;
    Get.to(RegisterBaptismScreen());
  }

  void checkButton() {
    if (indexPage == 0) {
      bool userResponse = address.addressCheck('personal');

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

        if (file == null) {
          isComplete = false;
          update();
          return;
        }

        if (i == userEdit.length - 1 &&
            userEdit[i].text.trim() != "" &&
            userResponse) {
          isComplete = true;
          update();
        }
      }
    } else {
      if (validInfo == true) {
        isComplete = true;
        update();
      } else {
        isComplete = false;
        update();
      }
    }
  }

  void back() {
    if (indexPage != 0) {
      indexPage--;
      validInfo = false;
      checkButton();
    } else {
      Get.back();
    }
  }

  void filePick(value) {
    file = value;
    checkButton();
  }

  void dropdownChange(
      {@required String section,
      @required String category,
      @required String value,
      index = 0}) async {
    switch (category) {
      case 'gender':
        userEdit[3].text = value;
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

  void actionRegister() {
    if (indexPage == maxPage) {
      register();
    } else {
      increasePage();
    }
  }

  void increasePage() {
    if (indexPage == 0) {
      indexPage++;
      validInfo = false;
      checkButton();
    }
  }

  void checkValid(value) {
    validInfo = value;
    checkButton();
  }

  void register() async {
    try {
      CustomShowDialog().openLoading();

      formData = form.FormData.fromMap({
        "user_id": user.userId,
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
        "birth_certification_file": await multipart.MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      var response = await api.parishEventJoin(
        endpoint: '/event/baptism/${event.id}',
        data: formData,
      );

      if (response.statusCode == 200) {
        CustomShowDialog().closeLoading();

        success.toSuccessScreen(
          eventData: event,
          fileData: file,
        );
      }
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();
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
