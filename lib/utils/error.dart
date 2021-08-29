import 'package:dio/dio.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/screens/login/login.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class ErrorController {
  GetStorage user = GetStorage('user');
  GetStorage token = GetStorage('token');

  ErrorResModel check(DioError error) {
    switch (error.type.toString().split(".")[1]) {
      case 'connectTimeout':
        return ErrorResModel.fromJson({
          "status": 500,
          "message": 'Connection Timeout',
        });
        break;
      default:
        return ErrorResModel.fromJson({
          "status": error.response?.statusCode,
          "message": error.response?.data['message'].toString(),
        });
    }
  }

  ErrorResModel checkGeneral(error) {
    return ErrorResModel.fromJson({
      "status": error['status'],
      "message": error['message'],
    });
  }

  void tokenError({ErrorResModel error}) {
    user.erase();
    token.erase();
    Get.offAll(LoginScreen());
    CustomShowDialog().generalError(error.message);
  }
}
