import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/sunday-school/sunday-school.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/sunday-school/sunday-school.dart';
import 'package:rhb_mobile_flutter/models/user/children.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class RegisterSundaySchoolController extends GetxController {
  var indexPage = 0;
  var maxPage = 1;
  int selectedEvent;
  var isComplete = false;
  List<SundaySchool> event;
  List<Child> childrenAvailable;
  List<ChildrenSelected> childrenSelected = [];
  List<Child> childrenSelect = [];
  final SundaySchoolController sundayController =
      Get.find<SundaySchoolController>();
  final UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    initial();
    super.onInit();
    ever(sundayController.childrenController.children, (value) {
      getAvailableChildren();
      update();
    });
    ever(sundayController.selectedEvent, (value) {
      filterEvent();
      getAvailableChildren();
      update();
    });
  }

  void initial() async {
    filterEvent();
    getAvailableChildren();
  }

  void filterEvent() {
    var filtered = sundayController.events
        .where((element) => element.id == sundayController.selectedEvent.value)
        .toList();

    event = filtered;
    selectedEvent = sundayController.selectedEvent.value;
    update();
  }

  void getAvailableChildren() async {
    try {
      var response = await sundayController.api.fetchSundaySchool(
          '/schedule/${sundayController.selectedEvent.value.toString()}/${userController.userId}');
      ChildrenResModel temp = ChildrenResModel.fromJson(response);
      childrenSelected = List<ChildrenSelected>.generate(
          temp.data.length,
          (index) => ChildrenSelected.fromJson({
                "status": false,
                "id": temp.data[index].id,
              }));
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
          switch (e.message) {
            case 'jwt expired':
              ErrorController().tokenError(error: e);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  void checkedbox(index, val) {
    childrenSelected[index].status = val;
    checkButton();
    update();
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
    update();
  }

  void submit() async {
    try {
      CustomShowDialog().openLoading();
      List temp =
          childrenSelected.where((element) => element.status == true).toList();
      await sundayController.api.joinSundaySchool(
          endpoint: '/children-join/${selectedEvent.toString()}',
          data: {
            "children": temp.map((v) => v.toJson()).toList(),
          });
      getBack('submit');
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

  void actionRegister() {
    if (indexPage == maxPage) {
      submit();
    } else {
      increasePage();
    }
  }

  void increasePage() {
    if (indexPage == 0) {
      indexPage++;
      filteredChildren();
    }
  }

  void getBack(dynamic section) {
    if (indexPage != 0 && section == null) {
      indexPage--;
      update();
    } else {
      CustomShowDialog().closeLoading();
      indexPage = 0;
      getAvailableChildren();
      Get.back(result: true);
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
