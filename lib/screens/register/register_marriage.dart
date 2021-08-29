import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/register/register_marriage.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/checkbox.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';
import 'package:rhb_mobile_flutter/widgets/form_personal.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart' as formatDate;

class RegisterMarriageScreen extends StatelessWidget {
  final RegisterMarriageController controller =
      Get.find<RegisterMarriageController>();

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
      body: GetBuilder<RegisterMarriageController>(builder: (_) {
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
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title:
                        'BPN: ${formatDate.DateFormat().backToFront(_.event.bpnDate)}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: 'Pernikahan: ${_.marriageDate}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: RehobotThemes.indigoRehobot,
                ),
                SizedBox(
                  height: 15,
                ),
                if (_.indexPage == 0)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: RehobotGeneralText(
                          title: 'Form Data Diri',
                          alignment: Alignment.centerLeft,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Form(
                        key: controller.formUser,
                        child: PersonalForm(
                          section: 'personal',
                          page: 'marriage',
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
                          subdistricts: controller
                              .address.personalSubdistrictsResListModel,
                          codePost:
                              controller.address.personalCodePostResListModel,
                          birthFile: controller.userBirthFile,
                          baptismFile: controller.userBaptismFile,
                          familyFile: controller.userFamilyFile,
                          identificationFile: controller.userIdentificationFile,
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
                          filePick: (belongs, value) {
                            controller.filePick(
                              section: 'personal',
                              category: belongs,
                              value: value,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: RehobotGeneralText(
                          title: 'Form Data Pasangan',
                          alignment: Alignment.centerLeft,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Form(
                        key: controller.formOther,
                        child: PersonalForm(
                          section: 'personal',
                          page: 'marriage',
                          dateFormat: 'dd/MM/yyyy',
                          name: controller.partner[0],
                          birthPlace: controller.partner[1],
                          bod: controller.partner[2],
                          gender: controller.partner[3].text,
                          occupation: controller.partner[4].text,
                          phone: controller.partner[7],
                          addressInput: controller.partner[5],
                          areaInput: controller.partner[6],
                          email: controller.partner[8],
                          address: controller.address.address[1],
                          provinces: controller.address.otherAddress,
                          cities: controller.address.otherCityResListModel,
                          districts:
                              controller.address.otherDistrictResListModel,
                          subdistricts:
                              controller.address.otherSubdistrictsResListModel,
                          codePost:
                              controller.address.otherCodePostResListModel,
                          birthFile: controller.otherBirthFile,
                          baptismFile: controller.otherBaptismFile,
                          familyFile: controller.otherFamilyFile,
                          identificationFile:
                              controller.otherIdentificationFile,
                          onChanged: (val) {
                            controller.checkButton();
                          },
                          dropdownChange: (section, value) {
                            controller.dropdownChange(
                              section: 'other',
                              category: section,
                              value: value,
                            );
                          },
                          filePick: (belongs, value) {
                            controller.filePick(
                              section: 'other',
                              category: belongs,
                              value: value,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                if (_.indexPage == 1)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: RehobotGeneralText(
                          title: 'Data Pasangan',
                          alignment: Alignment.centerLeft,
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
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
                        file: controller.userIdentificationFile,
                        baptismFile: controller.userBaptismFile,
                        birthFile: controller.userBirthFile,
                        familyFile: controller.userFamilyFile,
                        onpress: () {
                          controller.back();
                        },
                        section: 'personal',
                        upload: true,
                      ),
                      RehobotCardDetail(
                        padding: 0,
                        name: controller.partner[0].text,
                        birthPlace: controller.partner[1].text,
                        dob: controller.partner[2].text,
                        gender: controller.partner[3].text,
                        occupation: controller.partner[4].text,
                        address: controller.partner[5].text,
                        area: controller.partner[6].text,
                        phone: controller.partner[7].text,
                        email: controller.partner[8].text,
                        province: controller.address.address[1].province,
                        city: controller.address.address[1].city,
                        district: controller.address.address[1].district,
                        subdistrict: controller.address.address[1].subdistrict,
                        codePost: controller.address.address[1].codePost,
                        file: controller.otherIdentificationFile,
                        baptismFile: controller.otherBaptismFile,
                        birthFile: controller.otherBirthFile,
                        familyFile: controller.otherFamilyFile,
                        onpress: () {
                          controller.back();
                        },
                        section: 'personal',
                        upload: true,
                      ),
                      RehobotCheckBox(
                          padding: 0,
                          description:
                              'Dengan ini data yang saya masukan adalah benar adanya',
                          value: _.validInfo,
                          onChanged: (val) {
                            _.checkValid(val);
                          })
                    ],
                  ),
                SizedBox(
                  height: 25,
                ),
                RehobotButton().roundedButton(
                  title: 'submit'.toUpperCase(),
                  context: context,
                  height: 5,
                  widthDivider: 40,
                  textColor: RehobotThemes.pageRehobot,
                  buttonColor: _.isComplete
                      ? RehobotThemes.activeRehobot
                      : RehobotThemes.inactiveText,
                  onPressed: _.isComplete
                      ? () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }

                          _.actionRegister();
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
