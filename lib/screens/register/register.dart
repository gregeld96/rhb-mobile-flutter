import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/register/register_controller.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/family_indicator/family_indicator.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/family_indicator/toggle_button.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/page_indicator/page_indicator.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/checkbox.dart';
import 'package:rhb_mobile_flutter/widgets/form_family.dart';
import 'package:rhb_mobile_flutter/widgets/form_personal.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

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
      body: GetBuilder<RegisterController>(
        builder: (controller) {
          if (controller.address.personalAddress.length < 1) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    RehobotGeneralText(
                      title: 'Form Data Diri',
                      alignment: Alignment.center,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: RehobotPageIndicator(
                        indexPage: controller.indexPage,
                        maxPage: controller.maxPage,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (controller.indexPage == 0)
                      Column(
                        children: [
                          Form(
                            key: controller.formUser,
                            child: PersonalForm(
                              section: 'personal',
                              page: 'register',
                              name: controller.user[0],
                              birthPlace: controller.user[1],
                              bod: controller.user[2],
                              gender: controller.user[3].text,
                              occupation: controller.user[4].text,
                              email: controller.user[5],
                              phone: controller.user[6],
                              password: controller.user[7],
                              confirmPassword: controller.user[8],
                              addressInput: controller.user[9],
                              areaInput: controller.user[10],
                              address: controller.address.address[0],
                              provinces: controller.address.personalAddress,
                              cities:
                                  controller.address.personalCityResListModel,
                              districts: controller
                                  .address.personalDistrictResListModel,
                              subdistricts: controller
                                  .address.personalSubdistrictsResListModel,
                              codePost: controller
                                  .address.personalCodePostResListModel,
                              file: controller.file,
                              filePick: (belongs, value) {
                                controller.filePick(value);
                              },
                              onChanged: (val) {
                                controller.checkButton();
                              },
                              dropdownChange: (section, val) {
                                controller.dropdownChange(
                                  section: 'personal',
                                  category: section,
                                  value: val,
                                );
                              },
                              dateFormat: 'dd/MM/yyyy',
                            ),
                          ),
                          SizedBox(
                            height: 50,
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
                              districts:
                                  controller.address.otherDistrictResListModel,
                              subdistricts: controller
                                  .address.otherSubdistrictsResListModel,
                              codePost:
                                  controller.address.otherCodePostResListModel,
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
                          )
                        ],
                      ),
                    if (controller.indexPage == 1)
                      Column(
                        children: [
                          RehobotGeneralText(
                            title: 'Mau menambahkan anggota keluarga ?',
                            alignment: Alignment.topLeft,
                            fontSize: 13,
                            fontWeight: null,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RehobotToggleButton(
                            value: controller.addFamily,
                            onToggle: (value) {
                              controller.toggleFamily(value);
                            },
                          ),
                          Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                RehobotGeneralText(
                                  title: 'Tambahkan anggota keluarga',
                                  alignment: Alignment.centerLeft,
                                  fontSize: 13,
                                  fontWeight: null,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RehobotFamilyIndicator(
                                      iconPath: 'assets/icons/parents-icon.svg',
                                      text: 'Orang Tua',
                                      section: null,
                                      value: controller.parent.length,
                                      onAdd: controller.addFamily == 0
                                          ? () {
                                              controller.add(controller.parent);
                                            }
                                          : null,
                                      onRemove: controller.addFamily == 0
                                          ? () {
                                              controller
                                                  .remove(controller.parent);
                                            }
                                          : null,
                                    ),
                                    RehobotFamilyIndicator(
                                      iconPath: 'assets/icons/couple-icon.svg',
                                      text: 'Pasangan',
                                      section: 'partner',
                                      value: controller.havePartner,
                                      onTaped: controller.addFamily == 0
                                          ? () {
                                              controller.togglePartner();
                                            }
                                          : null,
                                    ),
                                    RehobotFamilyIndicator(
                                      iconPath: 'assets/icons/child-icon.svg',
                                      text: 'Anak',
                                      section: null,
                                      value: controller.child.length,
                                      onAdd: controller.addFamily == 0
                                          ? () {
                                              controller.add(controller.child);
                                            }
                                          : null,
                                      onRemove: controller.addFamily == 0
                                          ? () {
                                              controller
                                                  .remove(controller.child);
                                            }
                                          : null,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                //Condition when parent > 0
                                if (controller.parent.length > 0)
                                  Container(
                                    child: Column(
                                      children: [
                                        RehobotGeneralText(
                                          title: 'Orang Tua',
                                          alignment: Alignment.centerLeft,
                                          fontSize: 24,
                                          fontWeight: null,
                                        ),
                                        Column(
                                          children: List.generate(
                                            controller.parent.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: FamilyForm(
                                                section: 'register',
                                                dateFormat: 'dd/MM/yyyy',
                                                name: controller?.parent[index]
                                                    [0],
                                                birthPlace: controller
                                                    ?.parent[index][1],
                                                bod: controller?.parent[index]
                                                    [2],
                                                gender: controller
                                                    ?.parent[index][3].text,
                                                onChange: (val) {
                                                  controller.checkButton();
                                                },
                                                dropdownOnChange: (value) {
                                                  controller.dropdownChange(
                                                    section: 'parents',
                                                    category: 'gender',
                                                    value: value,
                                                    index: index,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                //End if parent > 0
                                if (controller.havePartner)
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: RehobotGeneralText(
                                            title: 'Pasangan',
                                            alignment: Alignment.centerLeft,
                                            fontSize: 24,
                                            fontWeight: null,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                          ),
                                          child: FamilyForm(
                                            section: 'register',
                                            dateFormat: 'dd/MM/yyyy',
                                            name: controller.partner[0],
                                            birthPlace: controller.partner[1],
                                            bod: controller.partner[2],
                                            gender: controller.partner[3].text,
                                            onChange: (val) {
                                              controller.checkButton();
                                            },
                                            dropdownOnChange: (value) {
                                              controller.dropdownChange(
                                                section: 'partner',
                                                category: 'gender',
                                                value: value,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                //End if partner true
                                if (controller.child.length > 0)
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: RehobotGeneralText(
                                            title: 'Anak',
                                            alignment: Alignment.centerLeft,
                                            fontSize: 24,
                                            fontWeight: null,
                                          ),
                                        ),
                                        Column(
                                          children: List.generate(
                                            controller.child.length,
                                            (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                              ),
                                              child: FamilyForm(
                                                section: null,
                                                dateFormat: 'dd/MM/yyyy',
                                                name: controller.child[index]
                                                    [0],
                                                birthPlace:
                                                    controller.child[index][1],
                                                bod: controller.child[index][2],
                                                gender: controller
                                                    .child[index][3].text,
                                                onChange: (val) {
                                                  controller.checkButton();
                                                },
                                                dropdownOnChange: (value) {
                                                  controller.dropdownChange(
                                                    section: 'children',
                                                    category: 'gender',
                                                    value: value,
                                                    index: index,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                //End if children > 0
                              ],
                            ),
                          ),
                        ],
                      ),
                    if (controller.indexPage == 2)
                      Container(
                        child: Column(
                          children: [
                            RehobotCardDetail(
                              name: controller.user[0].text,
                              birthPlace: controller.user[1].text,
                              dob: controller.user[2].text,
                              gender: controller.user[3].text,
                              address: controller.user[9].text,
                              province: controller.address.address[0].province,
                              city: controller.address.address[0].city,
                              district: controller.address.address[0].district,
                              subdistrict:
                                  controller.address.address[0].subdistrict,
                              codePost: controller.address.address[0].codePost,
                              area: controller.user[10].text,
                              occupation: controller.user[4].text,
                              email: controller.user[5].text,
                              phone: controller.user[6].text,
                              upload: true,
                              file: controller.file,
                              onpress: () {
                                controller.goBack(0);
                              },
                              section: 'personal',
                            ),
                            if (controller.addFamily == 0)
                              Column(
                                children: [
                                  if (controller.parent.length > 0)
                                    Column(
                                      children: List.generate(
                                        controller.parent.length,
                                        (index) {
                                          return RehobotCardDetail(
                                            name: controller
                                                .parent[index][0].text,
                                            birthPlace: controller
                                                .parent[index][1].text,
                                            dob: controller
                                                .parent[index][2].text,
                                            gender: controller
                                                .parent[index][3].text,
                                            onpress: () {
                                              controller.goBack(1);
                                            },
                                            upload: false,
                                            section: null,
                                          );
                                        },
                                      ),
                                    ),
                                  if (controller.havePartner)
                                    RehobotCardDetail(
                                      name: controller.partner[0].text,
                                      birthPlace: controller.partner[1].text,
                                      dob: controller.partner[2].text,
                                      gender: controller.partner[3].text,
                                      onpress: () {
                                        controller.goBack(1);
                                      },
                                      upload: false,
                                      section: null,
                                    ),
                                  if (controller.child.length > 0)
                                    Column(
                                      children: List.generate(
                                        controller.child.length,
                                        (index) {
                                          return RehobotCardDetail(
                                            name:
                                                controller.child[index][0].text,
                                            birthPlace:
                                                controller.child[index][1].text,
                                            dob:
                                                controller.child[index][2].text,
                                            gender:
                                                controller.child[index][3].text,
                                            onpress: () {
                                              controller.goBack(1);
                                            },
                                            upload: false,
                                            section: null,
                                          );
                                        },
                                      ),
                                    )
                                ],
                              ),
                            SizedBox(
                              height: 30,
                            ),
                            RehobotCheckBox(
                              padding: 10,
                              description:
                                  'Dengan ini data yang saya masukan adalah benar adanya.',
                              value: controller.validInfo,
                              onChanged: (value) {
                                controller.checkValid(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 25,
                    ),
                    RehobotButton().roundedButton(
                      title: controller.indexPage == controller.maxPage
                          ? 'SUBMIT'
                          : 'NEXT',
                      context: context,
                      height: 10,
                      widthDivider: 30,
                      disabledColor: Colors.grey[200],
                      textColor: controller.isComplete
                          ? Colors.white
                          : Color.fromRGBO(179, 179, 179, 1),
                      buttonColor: controller.isComplete
                          ? RehobotThemes.activeRehobot
                          : Colors.grey[200],
                      fontWeight: false,
                      onPressed: controller.isComplete
                          ? () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              controller.actionRegister(context);
                            }
                          : null,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
