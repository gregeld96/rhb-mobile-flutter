import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/setting/update_data.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/form_personal.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class UpdateDataScreen extends StatelessWidget {
  final UpdateDataController controller = Get.put(UpdateDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Kembali',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 15,
          ),
          child: GetBuilder<UpdateDataController>(builder: (_) {
            return Column(
              children: [
                RehobotGeneralText(
                  title: 'Personal Data',
                  alignment: Alignment.centerLeft,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                Form(
                  key: controller.formUser,
                  child: PersonalForm(
                    section: 'personal',
                    page: 'update',
                    dateFormat: 'dd/MM/yyyy',
                    name: controller.userEdit[0],
                    birthPlace: controller.userEdit[1],
                    bod: controller.userEdit[2],
                    gender: controller.userEdit[3].text,
                    occupation: controller.userEdit[4].text,
                    phone: controller.userEdit[7],
                    addressInput: controller.userEdit[5],
                    areaInput: controller.userEdit[6],
                    email: controller.userEdit[8],
                    address: controller.address.address[0],
                    provinces: controller.address.personalAddress,
                    cities: controller.address.personalCityResListModel,
                    districts: controller.address.personalDistrictResListModel,
                    subdistricts:
                        controller.address.personalSubdistrictsResListModel,
                    codePost: controller.address.personalCodePostResListModel,
                    onChanged: (val) {
                      controller.checkButton();
                    },
                    dropdownChange: (section, value) {
                      controller.dropdownChange(
                        section: 'personal',
                        category: section,
                        value: value,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                RehobotGeneralText(
                  title: 'Kontak Darurat',
                  alignment: Alignment.centerLeft,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: controller.formOther,
                  child: PersonalForm(
                    section: 'other',
                    page: 'other',
                    name: controller.emergency[0],
                    relation: controller.emergency[1],
                    gender: controller.emergency[2].text,
                    phone: controller.emergency[3],
                    addressInput: controller.emergency[4],
                    areaInput: controller.emergency[5],
                    address: controller.address.address[1],
                    provinces: controller.address.otherAddress,
                    cities: controller.address.otherCityResListModel,
                    districts: controller.address.otherDistrictResListModel,
                    subdistricts:
                        controller.address.otherSubdistrictsResListModel,
                    codePost: controller.address.otherCodePostResListModel,
                    onChanged: (val) {
                      controller.checkButton();
                    },
                    dropdownChange: (section, val) {
                      controller.dropdownChange(
                        section: 'other',
                        category: section,
                        value: val,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                RehobotButton().roundedButton(
                  title: 'Submit'.toUpperCase(),
                  context: context,
                  height: 5,
                  widthDivider: 25,
                  textColor: controller.isComplete
                      ? RehobotThemes.pageRehobot
                      : Colors.grey[350],
                  buttonColor: controller.isComplete
                      ? RehobotThemes.activeRehobot
                      : RehobotThemes.inactiveRehobot,
                  onPressed: controller.isComplete
                      ? () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          controller.submit();
                        }
                      : null,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
