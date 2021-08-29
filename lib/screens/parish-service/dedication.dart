import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/parish/dedication.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/local_widget/card_event.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class DedicationParishScreen extends StatelessWidget {
  final DedicationParishController controller =
      Get.put(DedicationParishController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DedicationParishController>(builder: (_) {
      if (controller.listEvent == null || controller.listEvent.length < 1) {
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
                title: 'Tidak ada jadwal pelayanan Penyerahan Anak',
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
          children: List.generate(controller.listEvent.length, (idx) {
            return EventCard(
              name: controller.listEvent[idx].title,
              date: controller.listEvent[idx].date,
              time: controller.listEvent[idx].time,
              pic: controller.listEvent[idx].pic,
              quota: controller.listEvent[idx].quota,
              section: 'dedication',
              onPress: () {
                controller.selectEvent(controller.listEvent[idx].id);
              },
            );
          }),
        );
      }
    });
  }
}
