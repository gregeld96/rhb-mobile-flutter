import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/register/register_baptism.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/checkbox.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';
import 'package:rhb_mobile_flutter/widgets/form_personal.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class RegisterBaptismScreen extends StatelessWidget {
  final RegisterBaptismController controller =
      Get.find<RegisterBaptismController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          controller.back();
        },
        title: 'Kembali',
        context: context,
      ),
      body: GetBuilder<RegisterBaptismController>(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: 'Anda akan mendaftar untuk',
                    alignment: Alignment.centerLeft,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: _.event.title,
                    alignment: Alignment.centerLeft,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: 'Pelaksana: ${_.event.pic}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: 'Kuota: ${_.event.quota}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: '${_.event.date} | ${_.event.time}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                if (controller.indexPage == 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: PersonalForm(
                      section: 'personal',
                      page: 'baptism',
                      dateFormat: 'dd/MM/yyyy',
                      readOnly: true,
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
                      districts:
                          controller.address.personalDistrictResListModel,
                      subdistricts:
                          controller.address.personalSubdistrictsResListModel,
                      codePost: controller.address.personalCodePostResListModel,
                      file: controller.file,
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
                      filePick: (belongs, data) {
                        controller.filePick(data);
                      },
                    ),
                  ),
                if (controller.indexPage == 1)
                  Column(
                    children: [
                      RehobotCardDetail(
                        padding: 0,
                        name: controller.userEdit[0].text,
                        birthPlace: controller.userEdit[1].text,
                        dob: controller.userEdit[2].text,
                        gender: controller.userEdit[3].text,
                        occupation: controller.userEdit[4].text,
                        address: controller.userEdit[5].text,
                        area: controller.userEdit[6].text,
                        phone: controller.userEdit[7].text,
                        email: controller.userEdit[8].text,
                        province: controller.address.address[0].province,
                        city: controller.address.address[0].city,
                        district: controller.address.address[0].district,
                        subdistrict: controller.address.address[0].subdistrict,
                        codePost: controller.address.address[0].codePost,
                        file: controller.file,
                        onpress: () {
                          controller.back();
                        },
                        section: 'personal',
                        upload: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: RehobotCheckBox(
                          padding: 0,
                          description:
                              'Dengan ini data yang saya masukkan adalah benar adanya.',
                          value: controller.validInfo,
                          onChanged: (val) {
                            controller.checkValid(val);
                          },
                        ),
                      )
                    ],
                  ),
                RehobotButton().roundedButton(
                  title: controller.indexPage == 0
                      ? 'next'.toUpperCase()
                      : 'submit'.toUpperCase(),
                  context: context,
                  height: 5,
                  widthDivider: 30,
                  textColor: RehobotThemes.pageRehobot,
                  buttonColor: RehobotThemes.activeRehobot,
                  onPressed: controller.isComplete
                      ? () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          controller.actionRegister();
                        }
                      : null,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
