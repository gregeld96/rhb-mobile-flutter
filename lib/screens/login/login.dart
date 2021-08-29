import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'local_widgets/form_field.dart';
import '../../widgets/button.dart';
import 'package:rhb_mobile_flutter/controllers/login/login_controller.dart';
import 'package:get/get.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/login.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Image(
                  image: AssetImage('assets/images/GSKI-REHOBOT-LOGO.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                  key: _formKey,
                  child: Obx(
                    () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              RehobotTextFormField(
                                labelText: "No.Handphone / E-mail",
                                controller: controller.email,
                                onChanged: (val) {
                                  controller.checkButton();
                                },
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          'No.Handphone / Email is required',
                                    ),
                                  ],
                                ),
                                suffixIcon: false,
                              ),
                              RehobotTextFormField(
                                labelText: "Password",
                                controller: controller.password,
                                onChanged: (val) {
                                  controller.checkButton();
                                },
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText: 'Password is required',
                                    ),
                                  ],
                                ),
                                suffixIcon: true,
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            alignment: AlignmentDirectional.topEnd,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.transparent,
                              ),
                              onPressed: () {
                                controller.getForgotPasswordScreen();
                              },
                              child: Text(
                                "Lupa Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: RehobotButton().roundedButton(
                              height: 10,
                              widthDivider: 40,
                              context: context,
                              title: 'LOGIN',
                              buttonColor: Colors.white,
                              disabledColor: Colors.transparent,
                              textColor: controller.isLoginAllowed.value
                                  ? RehobotThemes.indigoRehobot
                                  : Colors.white,
                              onPressed: controller.isLoginAllowed.value
                                  ? () {
                                      if (_formKey.currentState.validate()) {
                                        controller.login(context);
                                      }
                                    }
                                  : null,
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Belum Terdaftar?',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.transparent,
                                    ),
                                    onPressed: () {
                                      controller.getRegisterScreen();
                                    },
                                    child: Text(
                                      "Daftar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
