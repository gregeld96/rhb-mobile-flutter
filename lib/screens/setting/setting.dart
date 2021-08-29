import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/setting/main.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.tab.backToHome();
        return;
      },
      child: Scaffold(
        appBar: RehobotAppBar().indigoTextAppBar(
          title: 'Setting',
          context: context,
        ),
        body: SingleChildScrollView(
          child: GetBuilder<SettingController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  children: [
                    ListBody(
                      children: List.generate(controller.list.length, (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: controller.functionList(index),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            controller.list[index].icon,
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            color: RehobotThemes.indigoRehobot,
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          RehobotGeneralText(
                                            title: controller.list[index].name,
                                            alignment: Alignment.center,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next_sharp,
                                      color: RehobotThemes.indigoRehobot,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 15,
                              thickness: 1.3,
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                      child: Image(
                        image:
                            AssetImage('assets/images/GSKI-REHOBOT-LOGO.png'),
                      ),
                    ),
                    Text(
                      'GSKI Rehobot App \n Ver. 1.0',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
