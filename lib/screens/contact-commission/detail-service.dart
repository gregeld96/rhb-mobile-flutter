import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom-service.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class DetailServiceScreen extends StatelessWidget {
  final ServiceConcomController controller =
      Get.find<ServiceConcomController>();

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
      body: SingleChildScrollView(
        child: GetBuilder<ServiceConcomController>(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                RehobotGeneralText(
                  title: _.selectedRequest.title,
                  alignment: Alignment.centerLeft,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                RehobotGeneralText(
                  title: 'As ${_.selectedRequest.role}',
                  alignment: Alignment.centerLeft,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(2, (index) {
                    return Row(
                      children: [
                        Icon(
                          index == 0
                              ? Icons.access_time
                              : Icons.location_on_outlined,
                          color: RehobotThemes.indigoRehobot,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 120,
                          child: Text(
                            index == 0
                                ? _.selectedRequest.time
                                : _.selectedRequest.location,
                            softWrap: true,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    );
                  }),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_sharp,
                      color: RehobotThemes.indigoRehobot,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      _.selectedRequest.date,
                      softWrap: true,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    RehobotGeneralText(
                      title: 'Crew',
                      alignment: Alignment.centerLeft,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    controller.selectedRequest.team.length > 0
                        ? Column(
                            children: List.generate(
                                controller.selectedRequest.team.length,
                                (index) {
                              return Row(
                                children: [
                                  Row(
                                    children: [
                                      RehobotGeneralText(
                                        title: '${index + 1}.',
                                        alignment: Alignment.centerLeft,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      RehobotGeneralText(
                                        title: controller.selectedRequest
                                            .team[index].roleName,
                                        alignment: Alignment.centerLeft,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RehobotGeneralText(
                                    title: controller
                                        .selectedRequest.team[index].userName,
                                    alignment: Alignment.centerLeft,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              );
                            }),
                          )
                        : Container(
                            height: Get.context.height / 8,
                            child: Center(
                              child: RehobotGeneralText(
                                title: 'Team TBA',
                                alignment: Alignment.center,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                    if (controller.selectedRequest.banner != '')
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            RehobotGeneralText(
                              title: 'Instagram Banner:',
                              alignment: Alignment.centerLeft,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: Get.context.height / 3,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                            )
                          ],
                        ),
                      ),
                    if (controller.section == 'request' &&
                        controller.selectedRequest.approval == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RehobotButton().roundedButton(
                              radius: 10,
                              title: 'Terima',
                              context: context,
                              height: 5,
                              widthDivider: Get.context.width / 15,
                              textColor: RehobotThemes.indigoRehobot,
                              buttonColor: RehobotThemes.pageRehobot,
                              onPressed: () {
                                controller.responseRequest(
                                  'detail',
                                  true,
                                  controller.selectedRequest.id,
                                );
                              },
                            ),
                            RehobotButton().roundedButton(
                              radius: 10,
                              title: 'Tolak',
                              context: context,
                              height: 5,
                              widthDivider: Get.context.width / 15,
                              textColor: RehobotThemes.indigoRehobot,
                              buttonColor: RehobotThemes.pageRehobot,
                              onPressed: () {
                                controller.responseRequest(
                                  'detail',
                                  false,
                                  controller.selectedRequest.id,
                                );
                              },
                            )
                          ],
                        ),
                      )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
