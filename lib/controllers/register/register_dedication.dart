import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/success/dedication.dart';
import 'package:rhb_mobile_flutter/controllers/user/children.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/models/user/children.dart';
import 'package:dio/src/form_data.dart' as form;
import 'package:rhb_mobile_flutter/screens/register/register_dedication.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class RegisterDedicationController extends GetxController {
  var indexPage = 0;
  var maxPage = 1;
  List<Child> childrenAvailable;
  List<ChildrenSelected> childrenSelected = [];
  List<Child> childrenSelect = [];
  Parish event;
  var isComplete = false;
  var validInfo = false;
  var formData;

  // Other Controller
  UserController user = Get.find<UserController>();
  UserChildController childrenController = Get.put(UserChildController());
  SuccessDedicationController success = Get.put(SuccessDedicationController());
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    super.onInit();
    ever(childrenController.children, (value) async {
      await getAvailableChildren();
      update();
    });
  }

  void toRegisterScreen() async {
    await getAvailableChildren();
    Get.to(RegisterDedicationScreen());
  }

  Future getAvailableChildren() async {
    try {
      indexPage = 0;

      var response = await api.parishEventSpecific(
        endpoint: '/user-child/${user.userId}',
      );

      ChildrenResModel temp = ChildrenResModel.fromJson(response);

      childrenSelected = List<ChildrenSelected>.generate(
        temp.data.length,
        (index) => ChildrenSelected.fromJson(
          {
            "status": false,
            "id": temp.data[index].id,
          },
        ),
      );

      childrenAvailable = temp.data;

      checkButton();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }

  void filteredChildren() {
    List temp =
        childrenSelected.where((element) => element.status == true).toList();
    childrenSelect = childrenAvailable.where((element) {
      for (int i = 0; i < temp.length; i++) {
        if (element.id == temp[i].id) {
          return true;
        }
      }
      return false;
    }).toList();
    checkButton();
  }

  void checkButton() {
    if (indexPage == 0) {
      List temp =
          childrenSelected.where((element) => element.status == true).toList();
      if (temp.length < 1) {
        isComplete = false;
        update();
      } else {
        isComplete = true;
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

  void checkedbox(index, val) {
    childrenSelected[index].status = val;
    checkButton();
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
      filteredChildren();
    }
  }

  void checkValid(value) {
    validInfo = value;
    checkButton();
  }

  void register() async {
    try {
      CustomShowDialog().openLoading();
      List temp =
          childrenSelected.where((element) => element.status == true).toList();

      formData = form.FormData.fromMap({
        "user_id": user.userId,
        "children": temp.map((v) => v.toJson()).toList(),
      });

      var response = await api.parishEventJoin(
          endpoint: '/event/dedication/${event.id}', data: formData);

      if (response.statusCode == 200) {
        CustomShowDialog().closeLoading();

        success.toSuccessScreen(
          eventData: event,
          list: childrenSelect,
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

class ChildrenSelected {
  bool status;
  int id;

  ChildrenSelected({this.status, this.id});

  ChildrenSelected.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
