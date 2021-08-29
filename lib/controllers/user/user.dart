import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/user/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:dio/src/form_data.dart' as form;
import 'package:dio/src/multipart_file.dart' as multipart;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/screens/login/login.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class UserController extends GetxController {
  GetStorage user = GetStorage('user');
  GetStorage token = GetStorage('token');
  dynamic picker = ImagePicker();
  int roles;
  var isVerified = true.obs;
  var memberId = '';
  var fullName = ''.obs;
  var profilePic = ''.obs;
  var phoneNumber = ''.obs;
  var email = ''.obs;
  var userBirthday = ''.obs;
  Address address;
  var userId = GetStorage('user').read('id');
  var birthPlace;
  var gender;
  var occupation;

  RestApiController rest = Get.put(RestApiController());

  void onInit() async {
    super.onInit();
  }

  Future getPersonalData() async {
    try {
      User userData = await rest.userProfile();
      int userRoles = await rest.userRole();
      roles = userRoles;
      profilePic.value = userData.profilePic;
      fullName.value = userData.fullName;
      email.value = userData.email;
      userId = userData.id;
      phoneNumber.value = userData.phoneNumber.toString();
      memberId = userData.memberId.toString();
      isVerified.value = userData.isVerified;
      userBirthday.value = userData.birthOfDate;
      address = userData.address;
      birthPlace = userData.birthPlace;
      gender = userData.gender;
      occupation = userData.occupation;
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          Get.offAll(LoginScreen());
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
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
            'name': fullName,
            'profile_pic': await multipart.MultipartFile.fromFile(
              _data.path,
              filename: _data.path.split('/').last,
            ),
          });

          var response = await rest.updateProfile(
              endpoint: '/profile-pic', data: formData);
          UserResModel temp = UserResModel.fromJson(response.data);
          user.remove('profilePic');
          user.write('profilePic', temp.data.profilePic);
          profilePic.value = user.read('profilePic');
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
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          Get.offAll(LoginScreen());
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
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
          'name': fullName,
          'profile_pic': await multipart.MultipartFile.fromFile(
            _data.path,
            filename: _data.path.split('/').last,
          ),
        });

        var response =
            await rest.updateProfile(endpoint: '/profile-pic', data: formData);
        UserResModel temp = UserResModel.fromJson(response.data);
        user.remove('profilePic');
        user.write('profilePic', temp.data.profilePic);
        profilePic.value = user.read('profilePic');
        update();
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          Get.offAll(LoginScreen());
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }

  Future removeProfile() async {
    try {
      var response = await rest.removeProfilePic();
      UserResModel temp = UserResModel.fromJson(response.data);
      user.remove('profilePic');
      user.write('profilePic', temp.data.profilePic ?? '');
      profilePic.value = user.read('profilePic');
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          Get.offAll(LoginScreen());
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }

  Future resetProfile() async {
    try {
      var userData = await rest.userProfile();
      user.erase();
      token.erase();
      user.write('id', userData.id);
      user.write('fullName', userData.fullName);
      token.write('access', userData.tokenUser);
      token.write('onesignal', userData.tokenOneSignal);
      token.write('firebase', userData.tokenFirebase);
      await rest.changeData(
        newToken: userData.tokenUser,
        newOneSignalToken: userData.tokenOneSignal,
        newFirebaseToken: userData.tokenFirebase,
      );
      await getPersonalData();
      return;
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          Get.offAll(LoginScreen());
          CustomShowDialog().generalError(e.message);
          break;
        default:
          CustomShowDialog().staticError();
      }
    }
  }

  Future resetData(UserResModel data) async {
    user.erase();
    token.erase();
    user.write('id', data.data.id);
    user.write('fullName', data.data.fullName);
    token.write('access', data.data.tokenUser);
    token.write('onesignal', data.data.tokenOneSignal);
    token.write('firebase', data.data.tokenFirebase);

    profilePic.value = data.data.profilePic;
    fullName.value = data.data.fullName;
    email.value = data.data.email;
    userId = data.data.id;
    phoneNumber.value = data.data.phoneNumber.toString();
    memberId = data.data.memberId.toString();
    isVerified.value = data.data.isVerified;
    userBirthday.value = data.data.birthOfDate;
    address = data.data.address;
    birthPlace = data.data.birthPlace;
    gender = data.data.gender;
    occupation = data.data.occupation;
    await rest.changeData(
      newToken: data.data.tokenUser,
      newOneSignalToken: data.data.tokenOneSignal,
      newFirebaseToken: data.data.tokenFirebase,
    );
    await rolesList();
    update();
  }

  Future rolesList() async {
    try {
      roles = await rest.userRole();
      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 422:
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        case 401:
          Get.offAll(LoginScreen());
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
