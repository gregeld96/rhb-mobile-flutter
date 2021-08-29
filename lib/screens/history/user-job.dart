import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom-service.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/history_card.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class JobHistoryScreen extends StatefulWidget {
  @override
  _JobHistoryScreenState createState() => _JobHistoryScreenState();
}

class _JobHistoryScreenState extends State<JobHistoryScreen> {
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
      body: GetBuilder<ServiceConcomController>(
        builder: (controller) {
          if (controller.historyRequest == null) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10,
                      ),
                      child: RehobotGeneralText(
                        title: 'History',
                        alignment: Alignment.centerLeft,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                    ),
                    NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!controller.isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          controller.loadData();
                        }
                        return;
                      },
                      child: ListBody(
                        children: List.generate(
                            controller.historyRequest.length, (index) {
                          return RehobotHistoryCard(
                            time: controller.historyRequest[index].time,
                            title: controller.historyRequest[index].title,
                            date: controller.historyRequest[index].date,
                            icon: controller.imageAPI +
                                '/mass/${controller.historyRequest[index].thumbnail}',
                            role: controller.historyRequest[index].role,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          );
                        }),
                      ),
                    ),
                    Container(
                      height: controller.isLoading ? 50.0 : 0,
                      color: Colors.transparent,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
