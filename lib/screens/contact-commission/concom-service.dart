import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom-service.dart';
import 'package:rhb_mobile_flutter/screens/contact-commission/local_widget/card-request.dart';
import 'package:rhb_mobile_flutter/screens/history/user-job.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/widgets/history_card.dart';

class ServiceContactCommissionScreen extends StatelessWidget {
  final ServiceConcomController controller = Get.put(ServiceConcomController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceConcomController>(builder: (_) {
      if (controller.historyRequest == null ||
          controller.onGoingRequest == null ||
          controller.listRequest == null) {
        return Container(
          width: Get.context.width,
          height: Get.context.height,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      return ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          RehobotGeneralText(
            title: 'Request',
            alignment: Alignment.centerLeft,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          Column(
            children: _.listRequest.length > 0
                ? List.generate(_.listRequest.length, (index) {
                    return CardRequest(
                      title: _.listRequest[index].title,
                      time: _.listRequest[index].time,
                      date: _.listRequest[index].date,
                      location: _.listRequest[index].location,
                      role: _.listRequest[index].role,
                      approval: _.listRequest[index].approval,
                      section: 'request',
                      detailPress: () {
                        _.detail(
                          'request',
                          _.listRequest[index].id,
                        );
                      },
                      responsePress: (value) {
                        _.responseRequest(
                          'home',
                          value,
                          _.listRequest[index].id,
                        );
                      },
                    );
                  })
                : [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Kamu tidak memiliki request job saat ini',
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
          SizedBox(
            height: 15,
          ),
          RehobotGeneralText(
            title: 'On Going',
            alignment: Alignment.centerLeft,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          Column(
            children: _.onGoingRequest.length > 0
                ? List.generate(_.onGoingRequest.length, (index) {
                    return CardRequest(
                      title: _.onGoingRequest[index].title,
                      time: _.onGoingRequest[index].time,
                      date: _.onGoingRequest[index].date,
                      location: _.onGoingRequest[index].location,
                      role: _.onGoingRequest[index].role,
                      approval: _.onGoingRequest[index].approval,
                      section: 'ongoing',
                      detailPress: () {
                        _.detail(
                          'ongoing',
                          _.onGoingRequest[index].id,
                        );
                      },
                      responsePress: (value) {},
                    );
                  })
                : [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Kamu tidak memiliki on-going job saat ini',
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  RehobotGeneralText(
                    title: 'History',
                    alignment: Alignment.centerLeft,
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(JobHistoryScreen());
                    },
                    child: RehobotGeneralText(
                      title: 'Lihat semua',
                      alignment: Alignment.centerRight,
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                height: 5,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: controller.historyRequest.length > 0
                      ? List.generate(
                          controller.historyRequest.length > 5
                              ? 5
                              : controller.historyRequest.length, (index) {
                          return RehobotHistoryCard(
                            time: controller.historyRequest[index].time,
                            title: controller.historyRequest[index].title,
                            date: controller.historyRequest[index].date,
                            icon: controller.historyRequest[index].thumbnail !=
                                    ''
                                ? controller.imageAPI +
                                    '/mass/${controller.historyRequest[index].thumbnail}'
                                : '',
                            role: controller.historyRequest[index].role,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          );
                        })
                      : [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Kamu tidak memiliki history',
                                ),
                              ),
                            ),
                          ),
                        ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
