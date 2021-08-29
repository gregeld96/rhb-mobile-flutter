import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/setting/change_password.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController controller =
      Get.put(ChangePasswordController());
  final _changeKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          controller.getBack();
        },
        title: 'Kembali',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: GetBuilder<ChangePasswordController>(builder: (_) {
            if (_.indexPage.value == 0) {
              return Column(
                children: [
                  RehobotGeneralText(
                    title: 'Ubah Password',
                    alignment: Alignment.center,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    alignText: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RehobotGeneralText(
                    title: 'Tuliskan password yang anda gunakan saat ini',
                    alignment: Alignment.center,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    alignText: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: RehobotTextField(
                      hintText: 'Old Password',
                      validator: (val) {},
                      controller: controller.currentPassword,
                      onChanged: (val) {
                        controller.checkButton('input');
                      },
                      suffixIcon: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RehobotButton().roundedButton(
                    title: 'Submit',
                    context: context,
                    height: 5,
                    widthDivider: 30,
                    textColor: controller.isComplete.value
                        ? RehobotThemes.pageRehobot
                        : RehobotThemes.inactiveText,
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
                  )
                ],
              );
            } else {
              return Form(
                key: _changeKey,
                child: Column(
                  children: [
                    RehobotGeneralText(
                      title: 'Ubah Password',
                      alignment: Alignment.center,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      alignText: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RehobotGeneralText(
                      title: 'Tuliskan password anda yang baru',
                      alignment: Alignment.center,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      alignText: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: RehobotTextField(
                        hintText: 'New Password',
                        validator: (val) {},
                        controller: controller.password,
                        onChanged: (val) {
                          controller.checkButton('');
                        },
                        suffixIcon: true,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      child: RehobotTextField(
                        hintText: 'Confirm New Password',
                        validator: (val) {
                          if (val != controller.password.text) {
                            return 'Not Match';
                          }
                        },
                        controller: controller.confirmPassword,
                        onChanged: (val) {
                          controller.checkButton('');
                        },
                        suffixIcon: true,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RehobotButton().roundedButton(
                      title: 'Submit',
                      context: context,
                      height: 5,
                      widthDivider: 30,
                      textColor: controller.isComplete.value
                          ? RehobotThemes.pageRehobot
                          : RehobotThemes.inactiveText,
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

                              if (_changeKey.currentState.validate()) {
                                controller.nextPage();
                              }
                            }
                          : null,
                    )
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
