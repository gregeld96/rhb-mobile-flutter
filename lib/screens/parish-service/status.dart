import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/parish/status.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/local_widget/card_event.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class StatusParishScreen extends StatelessWidget {
  final StatusParishController controller = Get.put(StatusParishController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StatusParishController>(
        builder: (_) {
          if (controller.listStatus == null ||
              controller.listStatus.length < 1) {
            return SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Image(
                    width: Get.context.width / 2,
                    image: AssetImage(
                        'assets/images/no-schedule-registration-complete-img.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RehobotGeneralText(
                    title: 'Belum ada jadwal pelayanan yang didaftarkan',
                    alignment: Alignment.center,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    alignText: TextAlign.center,
                  )
                ],
              ),
            );
          } else {
            return ListView(
              children: List.generate(controller.listStatus.length, (idx) {
                return EventCard(
                  name: controller.listStatus[idx].title,
                  date: controller.listStatus[idx].date,
                  time: controller.listStatus[idx].time,
                  pic: controller.listStatus[idx].pic,
                  status: controller.listStatus[idx].status,
                  section: 'non',
                );
              }),
            );
          }
        },
      ),
    );
  }
}
