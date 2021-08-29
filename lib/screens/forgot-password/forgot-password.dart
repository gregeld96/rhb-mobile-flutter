import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/forgot-password/forgot-password.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/text_field.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  final _forgotKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/forgot-password-img.png'),
              ),
              RehobotGeneralText(
                title: 'Reset Password',
                alignment: Alignment.center,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _forgotKey,
                child: Obx(() {
                  return Column(
                    children: [
                      Column(
                        children: List.generate(2, (index) {
                          return RehobotTextField(
                            inputType: TextInputType.text,
                            inputAction:
                                index == 0 ? null : TextInputAction.done,
                            suffixIcon: true,
                            hintText: index == 0
                                ? 'Password Baru'
                                : 'Ulang Password Baru',
                            validator: index == 0
                                ? null
                                : (val) {
                                    if (val != controller.password.text)
                                      return 'Not Match';
                                  },
                            controller: index == 0
                                ? controller.password
                                : controller.confirmPassword,
                            onChanged: (val) {
                              controller.checkButton('forgot');
                            },
                          );
                        }),
                      ),
                      SizedBox(
                        height: 30,
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
                                if (_forgotKey.currentState.validate()) {
                                  controller.submitPassword();
                                }
                              }
                            : null,
                      ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
