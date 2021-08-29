import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/success/dedication.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/detail_event.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/headline.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/hotline.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';

class SuccessDedicationScreen extends StatelessWidget {
  final SuccessDedicationController controller =
      Get.find<SuccessDedicationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SuccessDedicationController>(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: Get.context.height / 15,
            ),
            child: Column(
              children: [
                SuccessHeadline(
                  userFullName: controller.user.fullName.value,
                  section: 'penyerahan anak',
                  description:
                      'Anda telah berhasil mendaftarkan putra/putri untuk proses penyerahan anak.',
                ),
                SizedBox(
                  height: 15,
                ),
                DetailEventSuccess(
                  title: controller.event.title,
                  pic: controller.event.pic,
                  date: controller.event.date,
                  time: controller.event.time,
                ),
                Column(
                  children: List.generate(
                    controller.selectedChildren.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: RehobotCardDetail(
                          padding: 0,
                          name: _.selectedChildren[index].fullName,
                          birthPlace: _.selectedChildren[index].birthPlace,
                          dob: DateFormat().backToFront(
                              _.selectedChildren[index].birthOfDate),
                          gender: _.selectedChildren[index].gender,
                          onlineFile: _.selectedChildren[index]
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
                SizedBox(
                  height: 15,
                ),
                HotlineSuccess(
                  userPhone: controller.user.phoneNumber.value,
                  userFullName: controller.user.fullName.value,
                  userEmail: controller.user.email.value,
                  hotlineAddress: controller.hotline.address,
                  hotlineCity: controller.hotline.city,
                  hotlineCodePost: controller.hotline.codePost,
                  hotlineNumber: controller.hotline.hotline,
                  section: 'penyerahan anak',
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1.5,
                  thickness: 2,
                  color: Colors.grey[400],
                ),
                SizedBox(
                  height: 15,
                ),
                RehobotButton().roundedButton(
                    title: 'kembali ke beranda'.toUpperCase(),
                    context: context,
                    height: 10,
                    widthDivider: 50,
                    textColor: RehobotThemes.pageRehobot,
                    buttonColor: RehobotThemes.activeRehobot,
                    onPressed: () {
                      controller.back();
                    })
              ],
            ),
          ),
        );
      }),
    );
  }
}
