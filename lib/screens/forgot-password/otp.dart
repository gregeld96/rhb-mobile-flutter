import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/forgot-password/forgot-password.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/text_field.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class OTPScreen extends StatelessWidget {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
          context: context,
          title: 'Kembali',
          onpress: () {
            controller.getBack();
          }),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    if (controller.indexPage.value == 0)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/forgot-password-img.png'),
                            ),
                          ),
                          RehobotGeneralText(
                            title: 'Lupa Password',
                            alignment: Alignment.center,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          RehobotTextField(
                            hintText: 'Masukan nomor telpon anda. (62******)',
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.number,
                            validator: null,
                            controller: controller.phoneNumber,
                            onChanged: (val) {
                              controller.checkButton('otp');
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Kami akan mengirimkan kode OTP ke nomor telepon anda untuk mereset password Anda.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    if (controller.indexPage.value == 1)
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          RehobotGeneralText(
                            title: 'Masukan Kode OTP',
                            alignment: Alignment.center,
                            fontSize: 18,
                            fontWeight: null,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Kami telah mengirimkan kode OTP ke \n ${controller.secure}',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: List.generate(4, (index) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: RehobotTextField(
                                    inputAction: index == 3
                                        ? TextInputAction.done
                                        : TextInputAction.next,
                                    inputType: TextInputType.number,
                                    maxLength: 1,
                                    fontSize: 28,
                                    textAlign: TextAlign.center,
                                    hintText: null,
                                    validator: null,
                                    controller: controller.otp[index],
                                    onChanged: (val) {
                                      controller.checkButton('otp');
                                    },
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          CountdownTimer(
                            endTime: controller.endTime.value,
                            widgetBuilder: (_, time) {
                              if (time == null) {
                                return TextButton(
                                    onPressed: () {
                                      controller.getOTP();
                                    },
                                    child: Text('Kirim Ulang'));
                              }
                              return Text('Kirim Ulang (${time.sec} s)');
                            },
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    RehobotButton().roundedButton(
                      title: 'Kirim',
                      context: context,
                      height: 10,
                      widthDivider: 25,
                      textColor: controller.isComplete.value
                          ? Colors.white
                          : RehobotThemes.inactiveText,
                      disabledColor: RehobotThemes.inactiveRehobot,
                      buttonColor: controller.isComplete.value
                          ? RehobotThemes.activeRehobot
                          : RehobotThemes.inactiveRehobot,
                      onPressed: controller.isComplete.value
                          ? () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              controller.nextPage();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
