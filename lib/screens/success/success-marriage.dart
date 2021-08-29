import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/success/marriage.dart';
import 'package:rhb_mobile_flutter/screens/success/local_widgets/headline.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessMarriageScreen extends StatelessWidget {
  final SuccessMarriageController controller =
      Get.put(SuccessMarriageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SuccessMarriageController>(builder: (_) {
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
                  section: 'pernikahan',
                  description:
                      'Proses pendaftaran bimbingan pranikah telah berhasil didaftarkan.\nKami akan mengirimkan reminder kelengkapan data yang dibutuhkan melalui email.',
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: RehobotGeneralText(
                    title: 'Kelengkapan berkas yang harus dilengkapi:',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15.0),
                  child: Column(
                    children:
                        List.generate(controller.documents().length, (index) {
                      return Row(
                        children: [
                          RehobotGeneralText(
                            title: '${index + 1}.',
                            alignment: Alignment.centerLeft,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: RehobotGeneralText(
                                title: '${controller.documents()[index]}',
                                alignment: Alignment.centerLeft,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: RehobotGeneralText(
                    title:
                        'Apabila ada pertanyaan dapat menghubungi hotline dibawah berikut:',
                    alignment: Alignment.centerLeft,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10.0,
                    left: 20,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/hotline-icon.svg',
                        width: 17,
                        height: 17,
                        alignment: Alignment.centerLeft,
                        color: RehobotThemes.indigoRehobot,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RehobotGeneralText(
                        title: controller.hotline.hotline,
                        alignment: Alignment.centerLeft,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
