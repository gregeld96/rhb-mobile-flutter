import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/user/children.dart';
import 'package:rhb_mobile_flutter/models/user/history.dart';
import 'package:rhb_mobile_flutter/screens/Children/form.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:flutter/material.dart';
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:dio/src/form_data.dart' as form;
import 'package:rhb_mobile_flutter/screens/children/edit_form.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class UserChildController extends GetxController {
  TextEditingController name = new TextEditingController();
  TextEditingController birthPlace = new TextEditingController();
  TextEditingController bod = new TextEditingController();
  String gender;
  PickFile file;
  var formData;
  bool disable = true;
  var children = <Child>[].obs;
  String imageAPI = RestApiController.publicImageAPI;

  //Child History Event
  dynamic picker = ImagePicker();
  var tappedChild = 0.obs;
  List<Child> childData;
  int indexChild;
  int start = 0;
  int totalData;
  List<History> history;

  //Other Controller
  final UserController userController = Get.find<UserController>();
  RestApiController api = Get.find<RestApiController>();

  void onInit() async {
    await getChildren();
    super.onInit();
    ever(userController.fullName, (value) async {
      await getChildren();
      update();
    });
    ever(children, (value) {
      update();
    });
  }

  Future getChildren() async {
    try {
      children = <Child>[].obs;
      List<Child> temp = await api.fetchUserChildren();
      for (int i = 0; i < temp.length; i++) {
        children.add(temp[i]);
      }
      update();
      return true;
    } catch (e) {
      Get.snackbar('Error Get Children List', e.toString());
    }
  }

  void toAddChildScreen() {
    Get.to(AddChildScreen());
    onChange('add');
  }

  void toEditChildScreen() {
    Get.to(EditChildScreen());
    onChange('edit');
  }

  void onChange(String section) {
    switch (section) {
      case 'edit':
        if ((name.text.trim() != "") &&
            (birthPlace.text.trim() != "") &&
            (bod.text.trim() != "") &&
            (gender != null)) {
          disable = false;
          update();
        } else {
          disable = true;
          update();
        }
        break;
      default:
        if ((name.text.trim() != "") &&
            (birthPlace.text.trim() != "") &&
            (bod.text.trim() != "") &&
            (gender != null) &&
            file != null) {
          disable = false;
          update();
        } else {
          disable = true;
          update();
        }
        break;
    }
  }

  void dropdownChange(section, value) {
    gender = value;
    onChange(section);
  }

  void filePick(section, value) {
    file = value;
    onChange(section);
  }

  void submit() async {
    try {
      CustomShowDialog().openLoading();

      formData = form.FormData.fromMap({
        "full_name": name.text,
        "birth_of_date": bod.text,
        "birth_place": birthPlace.text,
        "gender": gender,
        "children_birth_certification_file":
            await multipart.MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      Child temp = await api.addChild(data: formData);
      children.add(temp);
      getback();
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
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  void submitEdit() async {
    try {
      CustomShowDialog().openLoading();

      formData = form.FormData.fromMap({
        "full_name": name.text,
        "birth_of_date": bod.text,
        "birth_place": birthPlace.text,
        "gender": gender,
        "children_birth_certification_file": file != null
            ? await multipart.MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last,
              )
            : null,
      });

      Child temp = await api.updateChild(
        endpoint: '/update/' + tappedChild.value.toString(),
        data: formData,
      );
      int index = children
          .map((element) {
            return element.id;
          })
          .toList()
          .indexWhere((element) => element == tappedChild.value);
      children[index] = temp;
      childData[0] = temp;
      getback();
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
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  void getback() {
    name = new TextEditingController();
    birthPlace = new TextEditingController();
    bod = new TextEditingController();
    gender = null;
    file = null;
    disable = true;
    formData = null;
    CustomShowDialog().closeLoading();
    Get.back();
    update();
  }

  void editSection(int id) {
    List<Child> temp = children.where((element) => element.id == id).toList();
    name.text = temp[0].fullName;
    birthPlace.text = temp[0].birthPlace;
    temp[0].birthOfDate != null
        ? bod.text = DateFormat().backToFront(temp[0].birthOfDate)
        : bod = new TextEditingController();
    gender = temp[0].gender;
    tappedChild.value = id;
    childData = temp;
    toEditChildScreen();
  }

  void profileChildTap(int id, int index) {
    tappedChild.value = id;
    indexChild = index;
    childData = children.where((element) => element.id == id).toList();
  }

  Future getImageFromGallery() async {
    try {
      FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );

      if (pickedFile != null) {
        PlatformFile file = pickedFile.files.first;
        if (file.size < 3100000) {
          PickFile _data = PickFile.from(
            PickFile(ext: file.extension, path: file.path),
          );

          var formData = form.FormData.fromMap({
            'name': childData[0].fullName,
            'child_profile_pic': await multipart.MultipartFile.fromFile(
              _data.path,
              filename: _data.path.split('/').last,
            ),
          });

          Child temp = await api.updateChild(
            endpoint: '/profile-pic/${tappedChild.value.toString()}',
            data: formData,
          );
          children[indexChild].profilePic = temp.profilePic;
          childData[0].profilePic = temp.profilePic;
          update();
        } else {
          Get.dialog(
            CupertinoAlertDialog(
              title: Text('Error'),
              content: Column(
                children: [
                  Image(
                    width: 120,
                    height: 140,
                    image: AssetImage('assets/images/upload-failed-img.png'),
                  ),
                  Text('File terlalu besar dari 3MB'),
                ],
              ),
              actions: [
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
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
      }
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

  Future getImageFromCamera() async {
    try {
      PickedFile pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        PickFile _data = PickFile.from(
          PickFile(ext: 'jpg', path: pickedFile.path),
        );

        var formData = form.FormData.fromMap({
          'name': childData[0].fullName,
          'child_profile_pic': await multipart.MultipartFile.fromFile(
            _data.path,
            filename: _data.path.split('/').last,
          ),
        });

        Child temp = await api.updateChild(
          endpoint: '/profile-pic/${tappedChild.value.toString()}',
          data: formData,
        );
        children[indexChild].profilePic = temp.profilePic;
        childData[0].profilePic = temp.profilePic;
        update();
      }
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

  Future removeProfile() async {
    try {
      Child temp = await api.removeProfileChild(
          endpoint: '/profile-pic/${tappedChild.value.toString()}');
      children[indexChild].profilePic = temp.profilePic;
      childData[0].profilePic = temp.profilePic;
      update();
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
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  Future removeChild() async {
    try {
      CustomShowDialog().openLoading();

      await api.updateChild(
        endpoint: '/remove-child/${tappedChild.value.toString()}',
        data: null,
      );
      bool result = await getChildren();
      if (result) {
        CustomShowDialog().closeLoading();
        Get.back();
        Get.back();
        update();
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
