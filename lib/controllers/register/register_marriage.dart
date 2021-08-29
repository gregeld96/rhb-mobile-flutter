import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/address/address.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/success/marriage.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:rhb_mobile_flutter/screens/register/register_marriage.dart';
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:dio/src/form_data.dart' as form;
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class RegisterMarriageController extends GetxController {
  var indexPage = 0;
  var maxPage = 1;
  List<TextEditingController> userEdit;
  List<TextEditingController> partner;
  PickFile userBirthFile;
  PickFile userIdentificationFile;
  PickFile userFamilyFile;
  PickFile userBaptismFile;
  PickFile otherBirthFile;
  PickFile otherIdentificationFile;
  PickFile otherFamilyFile;
  PickFile otherBaptismFile;
  Parish event;
  String marriageDate;
  var isComplete = false;
  var validInfo = false;
  var formData;
  final formUser = GlobalKey<FormState>();
  final formOther = GlobalKey<FormState>();

  // Other Controller
  final AddressController address = Get.put(AddressController());
  final UserController user = Get.find<UserController>();
  final SuccessMarriageController success =
      Get.put(SuccessMarriageController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() {
    address.createListAddress(2);
    super.onInit();
    ever(address.address, (value) {
      update();
    });
  }

  Future resetData() async {
    userEdit = List.generate(9, (inputField) => TextEditingController());
    partner = List.generate(9, (inputField) => TextEditingController());
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
    Get.to(RegisterMarriageScreen());
  }

  void checkButton() {
    if (indexPage == 0) {
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

      for (int i = 0; i < partner.length; i++) {
        if (partner[i].text.trim() == "") {
          isComplete = false;
          update();
          return;
        }

        if (!otherResponse) {
          isComplete = false;
          update();
          return;
        }

        if (userBirthFile == null ||
            userIdentificationFile == null ||
            userFamilyFile == null ||
            userBaptismFile == null ||
            otherBirthFile == null ||
            otherIdentificationFile == null ||
            otherFamilyFile == null ||
            otherBaptismFile == null) {
          isComplete = false;
          update();
          return;
        }

        if (i == partner.length - 1 &&
            partner[i].text.trim() != "" &&
            otherResponse) {
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

  void actionRegister() {
    if (indexPage == maxPage) {
      register();
    } else {
      increasePage();
    }
  }

  void dropdownChange({
    @required String section,
    @required String category,
    @required String value,
  }) async {
    switch (category) {
      case 'gender':
        switch (section) {
          case 'personal':
            userEdit[3].text = value;
            break;
          default:
            partner[3].text = value;
            break;
        }
        break;
      case 'occupation':
        switch (section) {
          case 'personal':
            userEdit[4].text = value;
            break;
          default:
            partner[4].text = value;
            break;
        }
        break;
      default:
        await address.addressFill(section, category, value);
        break;
    }
    checkButton();
  }

  void increasePage() {
    bool response;
    if (indexPage == 0) {
      if (formUser.currentState.validate()) {
        if (formOther.currentState.validate()) {
          response = true;
        } else {
          Get.snackbar(
              'Kesalahan Pengisian', 'Tolong periksa lagi semua field');
        }
      } else {
        Get.snackbar('Kesalahan Pengisian', 'Tolong periksa lagi semua field');
      }
    } else {
      response = true;
    }

    if (response) {
      indexPage++;
      validInfo = false;
      checkButton();
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

  void filePick({
    @required String section,
    @required String category,
    @required PickFile value,
  }) {
    switch (section) {
      case 'personal':
        switch (category) {
          case 'birth':
            userBirthFile = value;
            break;
          case 'identification':
            userIdentificationFile = value;
            break;
          case 'family':
            userFamilyFile = value;
            break;
          case 'baptism':
            userBaptismFile = value;
            break;
          default:
            break;
        }
        break;
      default:
        switch (category) {
          case 'birth':
            otherBirthFile = value;
            break;
          case 'identification':
            otherIdentificationFile = value;
            break;
          case 'family':
            otherFamilyFile = value;
            break;
          case 'baptism':
            otherBaptismFile = value;
            break;
          default:
            break;
        }
        break;
    }
    checkButton();
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
        "marriage_date": marriageDate,
        "bpn_id": event.id,
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
        "partner": {
          "full_name": partner[0].text,
          "birth_place": partner[1].text,
          "birth_of_date": partner[2].text,
          "gender": partner[3].text,
          "occupation": partner[4].text,
          "email": partner[8].text,
          "phone_number": partner[7].text,
          "address": {
            "address": partner[5].text,
            "province": address.address[1].province,
            "city": address.address[1].city,
            "district": address.address[1].district,
            "subdistrict": address.address[1].subdistrict,
            "postCode": address.address[1].codePost,
            "area": partner[6].text,
          },
        },
        "birth_certification_file": await multipart.MultipartFile.fromFile(
          userBirthFile.path,
          filename: userBirthFile.path.split('/').last,
        ),
        "family_certificate": await multipart.MultipartFile.fromFile(
          userFamilyFile.path,
          filename: userFamilyFile.path.split('/').last,
        ),
        "identification_file": await multipart.MultipartFile.fromFile(
          userIdentificationFile.path,
          filename: userIdentificationFile.path.split('/').last,
        ),
        "baptism_certification_file": await multipart.MultipartFile.fromFile(
          userBaptismFile.path,
          filename: userBaptismFile.path.split('/').last,
        ),
        "partner_birth_certification_file":
            await multipart.MultipartFile.fromFile(
          otherBirthFile.path,
          filename: otherBirthFile.path.split('/').last,
        ),
        "partner_family_certification_file":
            await multipart.MultipartFile.fromFile(
          otherFamilyFile.path,
          filename: otherFamilyFile.path.split('/').last,
        ),
        "partner_identification_file": await multipart.MultipartFile.fromFile(
          otherIdentificationFile.path,
          filename: otherIdentificationFile.path.split('/').last,
        ),
        "partner_baptism_certification_file":
            await multipart.MultipartFile.fromFile(
          otherBaptismFile.path,
          filename: otherBaptismFile.path.split('/').last,
        ),
      });

      var response = await api.parishEventJoin(
          endpoint: '/event/marriage/${event.id}', data: formData);

      if (response.statusCode == 200) {
        CustomShowDialog().closeLoading();

        success.toSuccessScreen();
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
