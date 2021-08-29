import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/register/register_dedication.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/screens/register/local_widget/checkbox.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_child.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/loading.dart';

class RegisterDedicationScreen extends StatelessWidget {
  final RegisterDedicationController controller =
      Get.find<RegisterDedicationController>();

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
      body: GetBuilder<RegisterDedicationController>(builder: (_) {
        if (_.event == null || _.childrenAvailable == null) {
          return LoadingContent();
        } else {
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
                      child: Column(
                        children: [
                          Column(
                            children: List.generate(_.childrenAvailable.length,
                                (index) {
                              return CardChild(
                                id: _.childrenAvailable[index].id,
                                name: _.childrenAvailable[index].fullName,
                                birthPlace:
                                    _.childrenAvailable[index]?.birthPlace,
                                dob: _.childrenAvailable[index]?.birthOfDate,
                                gender: _.childrenAvailable[index]?.gender,
                                onlineFile: _.childrenAvailable[index]
                                    .childBirthCertificationFile,
                                checkboxValue: _.childrenSelected[index].status,
                                onpress: () {
                                  _.childrenController.editSection(
                                      _.childrenAvailable[index].id);
                                },
                                onSelected: (id, val) {
                                  _.checkedbox(index, val);
                                },
                              );
                            }),
                          ),
                          RehobotButton().roundedButton(
                            title: 'Tambahkan Anak',
                            context: context,
                            height: 10,
                            widthDivider: 40,
                            radius: 10,
                            textColor: RehobotThemes.indigoRehobot,
                            buttonColor: RehobotThemes.pageRehobot,
                            fontWeight: false,
                            onPressed: () {
                              _.childrenController.toAddChildScreen();
                            },
                          ),
                        ],
                      ),
                    ),
                  if (controller.indexPage == 1)
                    Column(
                      children: [
                        Column(
                          children: List.generate(
                            controller.childrenSelect.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: RehobotCardDetail(
                                  padding: 10,
                                  name: _.childrenSelect[index].fullName,
                                  birthPlace:
                                      _.childrenSelect[index].birthPlace,
                                  dob: DateFormat().backToFront(
                                      _.childrenSelect[index].birthOfDate),
                                  gender: _.childrenSelect[index].gender,
                                  onlineFile: _.childrenSelect[index]
                                      .childBirthCertificationFile,
                                  onpress: null,
                                  upload: true,
                                  section: 'family',
                                  edit: false,
                                ),
                              );
                            },
                          ),
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
                    buttonColor: controller.isComplete
                        ? RehobotThemes.activeRehobot
                        : RehobotThemes.inactiveText,
                    onPressed: controller.isComplete
                        ? () {
                            controller.actionRegister();
                          }
                        : null,
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
