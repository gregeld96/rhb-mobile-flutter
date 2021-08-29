import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/models/utils/address_model.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class AddressController extends GetxController {
  // Setup
  RestApiController api = Get.find<RestApiController>();

  // Variable
  var address = <Address>[].obs;
  var personalAddress = <ProvinceResModel>[].obs;
  var personalCityResListModel = <CityResModel>[].obs;
  var personalDistrictResListModel = <DistrictResModel>[].obs;
  var personalSubdistrictsResListModel = <Kelurahan>[].obs;
  var personalCodePostResListModel = <CodePost>[].obs;
  var otherAddress = <ProvinceResModel>[].obs;
  var otherCityResListModel = <CityResModel>[].obs;
  var otherDistrictResListModel = <DistrictResModel>[].obs;
  var otherSubdistrictsResListModel = <Kelurahan>[].obs;
  var otherCodePostResListModel = <CodePost>[].obs;

  void createListAddress(int amount) {
    address = List<Address>.generate(amount, (index) => Address()).obs;
  }

  bool addressCheck(String userSection) {
    if (userSection != 'other') {
      if (address[0].province != null &&
          address[0].city != null &&
          address[0].district != null &&
          address[0].subdistrict != null &&
          address[0].codePost != null) return true;
      return false;
    } else {
      if (address[1].province != null &&
          address[1].city != null &&
          address[1].district != null &&
          address[1].subdistrict != null &&
          address[1].codePost != null) return true;
      return false;
    }
  }

  Future addressFill(section, category, value) async {
    switch (category) {
      case 'province':
        section == 'personal'
            ? address[0].province = value
            : address[1].province = value;
        break;
      case 'city':
        section == 'personal'
            ? address[0].city = value
            : address[1].city = value;
        break;
      case 'district':
        section == 'personal'
            ? address[0].district = value
            : address[1].district = value;
        break;
      case 'subdistrict':
        section == 'personal'
            ? address[0].subdistrict = value
            : address[1].subdistrict = value;
        break;
      case 'codePost':
        section == 'personal'
            ? address[0].codePost = value
            : address[1].codePost = value;
        break;
      default:
    }
    await getAddress(section, value, category);
  }

  void resetData(section, category, value) {
    switch (category) {
      case 'province':
        section == 'personal'
            ? address[0].province = value
            : address[1].province = value;
        break;
      case 'city':
        section == 'personal'
            ? address[0].city = value
            : address[1].city = value;
        break;
      case 'district':
        section == 'personal'
            ? address[0].district = value
            : address[1].district = value;
        break;
      case 'subdistrict':
        section == 'personal'
            ? address[0].subdistrict = value
            : address[1].subdistrict = value;
        break;
      case 'codePost':
        section == 'personal'
            ? address[0].codePost = value
            : address[1].codePost = value;
        break;
      default:
    }
  }

  Future getProvince() async {
    try {
      var _json = await api.fetchProvince();
      personalAddress = List.generate(
          _json.length, (i) => ProvinceResModel.fromJson(_json[i])).obs;
      otherAddress = List.generate(
          _json.length, (i) => ProvinceResModel.fromJson(_json[i])).obs;
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          switch (e.message) {
            case 'Connection Timeout':
              CustomShowDialog().generalError(e.message);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  Future getAddress(String section, String value, String category) async {
    var _json;
    try {
      switch (category) {
        case 'province':
          _json = await api.fetchAddress(endpoint: '/cities/', data: {
            "province": value,
          });

          if (section == "personal") {
            personalCityResListModel = List.generate(
                _json.length, (i) => CityResModel.fromJson(_json[i])).obs;
            personalDistrictResListModel = <DistrictResModel>[].obs;
            personalSubdistrictsResListModel = <Kelurahan>[].obs;
            personalCodePostResListModel = <CodePost>[].obs;
          } else {
            otherCityResListModel = List.generate(
                _json.length, (i) => CityResModel.fromJson(_json[i])).obs;
            otherDistrictResListModel = <DistrictResModel>[].obs;
            otherSubdistrictsResListModel = <Kelurahan>[].obs;
            otherCodePostResListModel = <CodePost>[].obs;
          }

          resetData(section, 'city', null);
          resetData(section, 'district', null);
          resetData(section, 'subdistrict', null);
          resetData(section, 'codePost', null);
          break;
        case 'city':
          _json = await api.fetchAddress(endpoint: '/districts/', data: {
            "city": value,
          });
          if (section == "personal") {
            personalDistrictResListModel = List.generate(
                _json.length, (i) => DistrictResModel.fromJson(_json[i])).obs;
            personalSubdistrictsResListModel = <Kelurahan>[].obs;
            personalCodePostResListModel = <CodePost>[].obs;
          } else {
            otherDistrictResListModel = List.generate(
                _json.length, (i) => DistrictResModel.fromJson(_json[i])).obs;
            otherSubdistrictsResListModel = <Kelurahan>[].obs;
            otherCodePostResListModel = <CodePost>[].obs;
          }
          resetData(section, 'district', null);
          resetData(section, 'subdistrict', null);
          resetData(section, 'codePost', null);
          break;
        case 'district':
          _json = await api.fetchAddress(endpoint: '/subdistricts/', data: {
            "district": value,
          });
          if (section == "personal") {
            personalSubdistrictsResListModel = List.generate(
                _json['kelurahan'].length,
                (i) => Kelurahan.fromJson(_json['kelurahan'][i])).obs;
            personalCodePostResListModel = List.generate(
                _json['kode_post'].length,
                (i) => CodePost.fromJson(_json['kode_post'][i])).obs;
          } else {
            otherSubdistrictsResListModel = List.generate(
                _json['kelurahan'].length,
                (i) => Kelurahan.fromJson(_json['kelurahan'][i])).obs;
            otherCodePostResListModel = List.generate(_json['kode_post'].length,
                (i) => CodePost.fromJson(_json['kode_post'][i])).obs;
          }
          resetData(section, 'subdistrict', null);
          resetData(section, 'codePost', null);
          break;
        default:
          break;
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          switch (e.message) {
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
