import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/form_family.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/controllers/user/children.dart';

class AddChildScreen extends StatelessWidget {
  final UserChildController controller = Get.put(UserChildController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          controller.getback();
        },
        title: 'Kembali',
        context: context,
      ),
      body: SingleChildScrollView(child: GetBuilder<UserChildController>(
        builder: (controller) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Column(
              children: [
                RehobotGeneralText(
                  title: 'Anak',
                  alignment: Alignment.centerLeft,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                FamilyForm(
                  onChange: (val) {
                    controller.onChange('add');
                  },
                  dropdownOnChange: (value) {
                    controller.dropdownChange('add', value);
                  },
                  filePick: (value) {
                    controller.filePick('add', value);
                  },
                  name: controller.name,
                  birthPlace: controller.birthPlace,
                  bod: controller.bod,
                  gender: controller.gender,
                  dateFormat: 'dd/MM/yyyy',
                  section: 'add',
                  file: controller.file,
                ),
                SizedBox(
                  height: 10,
                ),
                RehobotButton().roundedButton(
                  title: 'submit'.toUpperCase(),
                  context: context,
                  height: 10,
                  widthDivider: MediaQuery.of(context).size.width / 15,
                  textColor: RehobotThemes.inactiveRehobot,
                  buttonColor: controller.disable
                      ? RehobotThemes.inactiveRehobot
                      : RehobotThemes.activeRehobot,
                  onPressed: controller.disable
                      ? null
                      : () {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          controller.submit();
                        },
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
