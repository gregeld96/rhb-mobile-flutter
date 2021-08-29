import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/setting/notification.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button_switch.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Kembali',
        context: context,
      ),
      body: GetBuilder<NotificationSettingController>(builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RehobotGeneralText(
                  title: 'Notifikasi',
                  alignment: Alignment.center,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    _.changeStatusPush();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RehobotGeneralText(
                            title: 'Disable Push Notifikasi',
                            alignment: Alignment.centerLeft,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RehobotGeneralText(
                            title: 'Matikan notifikasi dari Rehobot',
                            alignment: Alignment.centerLeft,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          )
                        ],
                      ),
                      RehobotButtonSwitch(
                        colorActive: RehobotThemes.activeRehobot,
                        colorInActive: RehobotThemes.inactiveRehobot,
                        toggleValue: _.userSubscription,
                        onTaped: () {
                          _.changeStatusPush();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
