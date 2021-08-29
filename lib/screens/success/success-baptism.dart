import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/success/baptism.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/detail_event.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/headline.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/hotline.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/card_detail.dart';

class SuccessBaptismScreen extends StatelessWidget {
  final SuccessBaptismController controller =
      Get.find<SuccessBaptismController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SuccessBaptismController>(builder: (_) {
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
                  section: 'pembaptisan',
                  description: 'Anda berhasil mendaftar untuk pembaptisan.',
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
                RehobotCardDetail(
                  padding: 0,
                  name: controller.user.fullName.value,
                  birthPlace: controller.user.birthPlace,
                  dob: DateFormat()
                      .backToFront(controller.user.userBirthday.value),
                  gender: controller.user.gender,
                  occupation: controller.user.occupation,
                  address: controller.user.address.address,
                  area: controller.user.address.area,
                  phone: controller.user.phoneNumber.value,
                  email: controller.user.email.value,
                  province: controller.user.address.province,
                  city: controller.user.address.city,
                  district: controller.user.address.district,
                  subdistrict: controller.user.address.subdistrict,
                  codePost: controller.user.address.postCode,
                  file: controller.file,
                  onpress: () {},
                  section: 'personal',
                  edit: false,
                  upload: true,
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
                  section: 'pembaptisan',
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
