import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/address/address.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/success/success.dart';
import 'package:rhb_mobile_flutter/screens/login/login.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:dio/src/form_data.dart' as form;
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class RegisterController extends GetxController {
  var indexPage = 0;
  var maxPage = 2;
  List<TextEditingController> user;
  List<TextEditingController> emergency;
  List<TextEditingController> partner =
      List.generate(4, (inputField) => TextEditingController());
  List child = [];
  List parent = [];
  PickFile file;
  var havePartner = false;
  var addFamily = 1;
  var isComplete = true;
  var validInfo = false;
  final formUser = GlobalKey<FormState>();
  final formOther = GlobalKey<FormState>();
  var formData;

  //Other Controller
  final AddressController address = Get.put(AddressController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    address.createListAddress(2);
    user = List.generate(11, (inputField) => TextEditingController());
    emergency = List.generate(6, (inputField) => TextEditingController());
    await address.getProvince();
    checkButton();
    super.onInit();
    ever(address.address, (value) {
      update();
    });
  }

  void checkValid(value) {
    validInfo = value;
    checkButton();
  }

  void increasePage() async {
    try {
      CustomShowDialog().openLoading();

      bool response;
      if (indexPage == 0) {
        if (formUser.currentState.validate()) {
          if (formOther.currentState.validate()) {
            var res = await api.userPost(
              endpoint: '/check-email',
              data: {
                "email": user[5].text,
              },
            );

            if (res.statusCode == 200) {
              response = true;
            }
          } else {
            throw ErrorController().checkGeneral({
              "status": 400,
              "message": 'Tolong periksa lagi semua field',
            });
          }
        } else {
          throw ErrorController().checkGeneral({
            "status": 400,
            "message": 'Tolong periksa lagi semua field',
          });
        }
      } else {
        response = true;
      }

      if (response) {
        CustomShowDialog().closeLoading();
        indexPage++;
        validInfo = false;
        checkButton();
      }
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();
      switch (e.statusCode) {
        case 400:
        case 401:
        case 422:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }

  void toggleFamily(index) {
    addFamily = index;
    if (index == 1) {
      havePartner = false;
      parent.clear();
      child.clear();
    }
    checkButton();
  }

  void togglePartner() {
    havePartner = !havePartner;
    checkButton();
  }

  void add(family) {
    family.add(List.generate(4, (inputField) => TextEditingController()));
    checkButton();
  }

  void remove(family) {
    family.removeLast();
    checkButton();
  }

  void goBack(index) {
    indexPage = index;
    checkButton();
  }

  void checkButton() {
    if (indexPage == 0) {
      bool userResponse = address.addressCheck('personal');
      bool otherResponse = address.addressCheck('other');

      for (int i = 0; i < user.length; i++) {
        if (user[i].text.trim() == "") {
          isComplete = false;
          update();
          return;
        }

        if (!userResponse) {
          isComplete = false;
          update();
          return;
        }

        if (i == user.length - 1 && user[i].text.trim() != "" && userResponse) {
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

        if (file == null) {
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
    } else if (indexPage == 1) {
      if (addFamily == 1) {
        isComplete = true;
        update();
      } else {
        isComplete = false;

        if (child.length > 0) {
          for (int i = 0; i < child.length; i++) {
            for (int j = 0; j < child[i].length; j++) {
              if (child[i][j].text.trim() == "") {
                isComplete = false;
                update();
                return;
              }
              if (j == child[i].length - 1 && child[i][j].text.trim() != "") {
                isComplete = true;
                update();
              }
            }
          }
        }

        if (havePartner) {
          for (int i = 0; i < partner.length; i++) {
            if (partner[i].text.trim() == "") {
              isComplete = false;
              update();
              return;
            }
            if (i == partner.length - 1 && partner[i].text.trim() != "") {
              isComplete = true;
              update();
            }
          }
        }

        if (parent.length > 0) {
          for (int i = 0; i < parent.length; i++) {
            for (int j = 0; j < parent[i].length; j++) {
              if (parent[i][j].text.trim() == "") {
                isComplete = false;
                update();
                return;
              }
              if (j == parent[i].length - 1 && parent[i][j].text.trim() != "") {
                isComplete = true;
                update();
              }
            }
          }
        }
        update();
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

  void dropdownChange(
      {@required String section,
      @required String category,
      @required String value,
      index = 0}) async {
    switch (category) {
      case 'gender':
        switch (section) {
          case 'personal':
            user[3].text = value;
            break;
          case 'partner':
            partner[3].text = value;
            break;
          case 'parents':
            parent[index][3].text = value;
            break;
          case 'children':
            child[index][3].text = value;
            break;
          default:
            emergency[2].text = value;
            break;
        }
        break;
      case 'occupation':
        if (section == 'personal') user[4].text = value;
        break;
      default:
        await address.addressFill(section, category, value);
        break;
    }
    checkButton();
  }

  void filePick(value) {
    file = value;
    checkButton();
  }

  void back() {
    if (indexPage != 0) {
      indexPage--;
      validInfo = false;
      checkButton();
    } else {
      Get.offAll(LoginScreen());
    }
  }

  void actionRegister(context) {
    if (indexPage == maxPage) {
      register(context);
    } else {
      increasePage();
    }
  }

  void register(context) async {
    try {
      CustomShowDialog().openLoading();

      formData = form.FormData.fromMap({
        "full_name": user[0].text,
        "birth_place": user[1].text,
        "birth_of_date": user[2].text,
        "gender": user[3].text,
        "occupation": user[4].text,
        "email": user[5].text,
        "phone_number": user[6].text,
        "password": user[7].text,
        "address": {
          "address": user[9].text,
          "province": address.address[0].province,
          "city": address.address[0].city,
          "district": address.address[0].district,
          "subdistrict": address.address[0].subdistrict,
          "postCode": address.address[0].codePost,
          "area": user[10].text,
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
        "parents": parent.length > 0
            ? List.generate(parent.length, (index) {
                return {
                  "full_name": parent[index][0].text,
                  "birth_place": parent[index][1].text,
                  "birth_of_date": parent[index][2].text,
                  "gender": parent[index][3].text,
                };
              })
            : parent,
        "childrens": child.length > 0
            ? List.generate(child.length, (index) {
                return {
                  "full_name": child[index][0].text,
                  "birth_place": child[index][1].text,
                  "birth_of_date": child[index][2].text,
                  "gender": child[index][3].text,
                };
              })
            : child,
        "partner": havePartner
            ? {
                "full_name": partner[0].text,
                "birth_place": partner[1].text,
                "birth_of_date": partner[2].text,
                "gender": partner[3].text,
              }
            : null,
        "identification_file": await multipart.MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      var response = await api.userPost(endpoint: '/register', data: formData);

      if (response.statusCode == 201) {
        indexPage = 0;
        CustomShowDialog().closeLoading();

        Get.to(
          SuccessScreen(
            imageName: 'thanks-img.png',
            onPress: () {
              Get.offAll(LoginScreen());
            },
            description:
                'Proses pendaftaran anggota GSKI Rehobot Kelapa Gading telah selesai, silahkan masuk ke aplikasi melalui tombol dibawah ini.',
            buttonTitle: 'SIGN IN',
            title: 'Terima Kasih',
          ),
        );
      }
    } on ErrorResModel catch (e) {
      CustomShowDialog().closeLoading();

      switch (e.statusCode) {
        case 422:
          CustomShowDialog().generalError(e.message);
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
