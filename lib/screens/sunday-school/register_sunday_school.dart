import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/sunday-school/register-school.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/screens/view_image/online_view.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_child.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/loading.dart';

class RegisterSundaySchool extends StatelessWidget {
  final RegisterSundaySchoolController controller =
      Get.put(RegisterSundaySchoolController());

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          controller.getBack(null);
        },
        title: 'Kembali',
        context: context,
      ),
      body: GetBuilder<RegisterSundaySchoolController>(builder: (_) {
        if (_.event == null || _.childrenAvailable == null) {
          return LoadingContent();
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: 'Anda akan mendaftarkan untuk',
                    alignment: Alignment.centerLeft,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: _.event[0].title,
                    alignment: Alignment.centerLeft,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: RehobotGeneralText(
                    title: 'Pelaksana: ${_.event[0].pic}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(2, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              index == 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: SvgPicture.asset(
                                        'assets/icons/profile-name-icon.svg',
                                        height: 15,
                                        width: 15,
                                        color: RehobotThemes.indigoRehobot,
                                      ),
                                    )
                                  : Icon(
                                      Icons.date_range_outlined,
                                      color: RehobotThemes.indigoRehobot,
                                      size: 19,
                                    ),
                              SizedBox(
                                width: 5,
                              ),
                              RehobotGeneralText(
                                title: index == 0
                                    ? '${_.event[0].ageMin}-${_.event[0].ageMax} Tahun'
                                    : _.event[0].day,
                                alignment: Alignment.centerLeft,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                    Column(
                      children: List.generate(2, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: index == 0
                                    ? EdgeInsets.symmetric(horizontal: 0)
                                    : EdgeInsets.symmetric(horizontal: 10.0),
                                child: SvgPicture.asset(
                                  index == 0
                                      ? 'assets/icons/kuota-icon.svg'
                                      : 'assets/icons/clock-icon.svg',
                                  height: 15,
                                  width: 15,
                                  color: RehobotThemes.indigoRehobot,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RehobotGeneralText(
                                title: index == 0
                                    ? 'Kuota ${_.event[0].quota}'
                                    : _.event[0].time,
                                alignment: Alignment.centerLeft,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/clock-icon.svg',
                        height: 15,
                        width: 15,
                        color: RehobotThemes.indigoRehobot,
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(_.event[0].activities.length,
                            (index) {
                          return RehobotGeneralText(
                            title:
                                '${index + 1}\. ${_.event[0].activities[index]}',
                            alignment: Alignment.topLeft,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          );
                        }),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: RehobotGeneralText(
                    title: 'Pilih Anak untuk Didaftarkan',
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                if (controller.indexPage == 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      children: List.generate(
                        _.childrenAvailable.length,
                        (index) {
                          return CardChild(
                            id: _.childrenAvailable[index].id,
                            name: _.childrenAvailable[index].fullName,
                            birthPlace: _.childrenAvailable[index].birthPlace,
                            dob: _.childrenAvailable[index].birthOfDate,
                            gender: _.childrenAvailable[index].gender,
                            onlineFile: _.childrenAvailable[index]
                                .childBirthCertificationFile,
                            checkboxValue: _.childrenSelected[index].status,
                            onpress: () {
                              _.sundayController.childrenController
                                  .editSection(_.childrenAvailable[index].id);
                            },
                            viewDocument: () {
                              Get.to(OnlineViewScreen(
                                document:
                                    '/akte-anak/${_.childrenAvailable[index].childBirthCertificationFile}',
                              ));
                            },
                            onSelected: (id, val) {
                              _.checkedbox(index, val);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                if (controller.indexPage == controller.maxPage)
                  Column(
                    children: List.generate(
                      controller.childrenSelect.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: RehobotCardDetail(
                            padding: 10,
                            name: _.childrenSelect[index].fullName,
                            birthPlace: _.childrenSelect[index].birthPlace,
                            dob: DateFormat().backToFront(
                                _.childrenSelect[index].birthOfDate),
                            gender: _.childrenSelect[index].gender,
                            onlineFile: _.childrenSelect[index]
                                .childBirthCertificationFile,
                            onpress: () {},
                            upload: true,
                            section: 'family',
                            edit: false,
                          ),
                        );
                      },
                    ),
                  ),
                if (controller.indexPage == 0)
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
                      _.sundayController.childrenController.toAddChildScreen();
                    },
                  ),
                SizedBox(
                  height: 30,
                ),
                RehobotButton().roundedButton(
                  title: controller.indexPage == 0
                      ? 'Submit'.toUpperCase()
                      : 'konfirmasi'.toUpperCase(),
                  context: context,
                  height: 10,
                  widthDivider: 40,
                  radius: 30,
                  textColor: RehobotThemes.pageRehobot,
                  buttonColor: controller.isComplete
                      ? RehobotThemes.activeRehobot
                      : RehobotThemes.inactiveText,
                  fontWeight: false,
                  onPressed: controller.isComplete
                      ? () {
                          _.actionRegister();
                        }
                      : null,
                ),
              ]),
            ),
          );
        }
      }),
    );
  }
}
