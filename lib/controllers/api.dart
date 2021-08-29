import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/config/setting.dart';
import 'package:dio/dio.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/models/register-payload.dart';
import 'package:rhb_mobile_flutter/models/user/history.dart';
import 'package:rhb_mobile_flutter/models/user/request.dart';
import 'package:rhb_mobile_flutter/models/user/role.dart';
import 'package:rhb_mobile_flutter/models/user/user.dart';
import 'package:rhb_mobile_flutter/models/worship/schedule.dart';
import 'package:rhb_mobile_flutter/models/worship/worship.dart';
import 'package:rhb_mobile_flutter/models/user/children.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';

String urlBased = GlobalSetting().url;
String prefixBased = GlobalSetting().prefix;

class RestApiController extends GetxController {
  // Url Control
  static String address = urlBased + prefixBased + 'addresses';
  static String getAddressAPINew = urlBased + prefixBased + 'addresses';
  static String userUrl = urlBased + prefixBased + 'users';
  static String childrenUrl = urlBased + prefixBased + 'children';
  static String publicImageAPI = urlBased + 'photos/public';
  static String privateImageUrl = urlBased + 'photos/private';
  static String dynamicUrl = urlBased + prefixBased + 'dynamic-pages';
  static String worshipUrl = urlBased + prefixBased + 'worships';
  static String sundayUrl = urlBased + prefixBased + 'sunday-schools';
  static String parishServiceUrl = urlBased + prefixBased + 'parish-services';
  static String chatUrl = urlBased + prefixBased + 'chat';

  // Other Component
  Dio dio;
  String token = GetStorage('token').read('access');
  String oneSignalToken = GetStorage('token').read('onesignal');
  String firebaseToken = GetStorage('token').read('firebase');

  // Other Controller
  UserController user;

  void onInit() {
    Get.lazyPut(() => user = UserController());
    dio = new Dio(new BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: 10 * 1000,
      receiveTimeout: 10 * 1000,
    ));
    super.onInit();
  }

  String getUrlBased() {
    return urlBased;
  }

  Future changeData({
    String newToken,
    String newOneSignalToken,
    String newFirebaseToken,
  }) {
    token = newToken;
    oneSignalToken = newOneSignalToken;
    firebaseToken = newFirebaseToken;
    return null;
  }

  Future<User> userProfile() async {
    try {
      var response = await dio.get(
        userUrl + '/fetch',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return UserResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<int> userRole() async {
    try {
      var userRoles = await dio.get(
        userUrl + '/role',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return UserRolesResModel.fromJson(userRoles.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<Emergency> userEmergencyData() async {
    try {
      var response = await dio.get(
        userUrl + '/emergency-data',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response.data != null
          ? EmergencyResModel.fromJson(response.data).data
          : null;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<List<UserRequest>> userRequest(String endpoint) async {
    try {
      var response = await dio.get(
        userUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return UserRequestResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future updateProfile({String endpoint, dynamic data}) async {
    try {
      var response = await dio.put(
        userUrl + endpoint,
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future removeProfilePic() async {
    try {
      var response = await dio.delete(
        userUrl + '/profile-pic',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future userPost({String endpoint, dynamic data}) async {
    try {
      var response = await dio.post(
        userUrl + endpoint,
        data: data,
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<List<Section>> worshipCategories() async {
    try {
      var response = await dio.get(
        worshipUrl + '/sections',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return WorshipResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<List<Schedule>> schedules(String endpoint) async {
    try {
      var response = await dio.get(
        worshipUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return ScheduleResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future dynamicContent(String endpoint) async {
    try {
      var response = await dio.get(
        dynamicUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<HistoryResModel> history(String section, String endpoint) async {
    try {
      var response = await dio.get(
        section == 'profile' ? worshipUrl + endpoint : userUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return HistoryResModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future updateRequest({dynamic data, String requestId}) async {
    try {
      var response = await dio.put(
        userUrl + '/job-response/$requestId',
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future fetchProvince() async {
    try {
      var response = await dio.get(address + '/province');
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future fetchAddress({String endpoint, dynamic data}) async {
    try {
      var response = await dio.post(address + endpoint, data: data);
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future joinEvent({dynamic data}) async {
    try {
      var response = await dio.post(
        worshipUrl + '/user',
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future fetchSundaySchool(String endpoint) async {
    try {
      var response = await dio.get(
        sundayUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future joinSundaySchool({dynamic data, String endpoint}) async {
    try {
      var response = await dio.post(
        sundayUrl + endpoint,
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<List<Child>> fetchUserChildren() async {
    try {
      var response = await dio.get(
        childrenUrl + '/user/' + user.userId.toString(),
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return ChildrenResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<Child> addChild({dynamic data}) async {
    try {
      var response = await dio.post(
        childrenUrl + '/add',
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return Child.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<Child> updateChild({String endpoint, dynamic data}) async {
    try {
      var response = await dio.put(
        childrenUrl + endpoint,
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return ChildResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<Child> removeProfileChild({String endpoint}) async {
    try {
      var response = await dio.delete(
        childrenUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );
      return ChildResModel.fromJson(response.data).data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future parishEventSpecific({
    String endpoint,
  }) async {
    try {
      var response = await dio.get(
        parishServiceUrl + endpoint,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future parishEventJoin({String endpoint, data}) async {
    try {
      var response = await dio.post(
        parishServiceUrl + endpoint,
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future<UserResModel> userFirebase() async {
    try {
      var response = await dio.get(
        chatUrl + '/user',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return UserResModel.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future updatedSeenChat() async {
    try {
      var response = await dio.put(
        chatUrl + '/seen',
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }

  Future sentMessage({dynamic data}) async {
    try {
      var response = await dio.post(
        chatUrl + '/message',
        data: data,
        options: Options(
          headers: {
            "access_token": token,
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      print(e.response);
      throw ErrorController().check(e);
    }
  }
}
