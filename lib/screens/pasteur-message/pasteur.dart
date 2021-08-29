import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/screens/pasteur-message/local_widgets/message_card.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/pasteur-message/pasteur-message.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';

class PasteurMessageScreen extends StatefulWidget {
  @override
  _PasteurMessageScreenState createState() => _PasteurMessageScreenState();
}

class _PasteurMessageScreenState extends State<PasteurMessageScreen> {
  final PasteurMessageController controller =
      Get.find<PasteurMessageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RehobotAppBar().indigoAppBar(
          onpress: () {
            Get.back();
          },
          title: 'Pastor\'s Message',
          context: context,
        ),
        body: GetBuilder<PasteurMessageController>(
          builder: (controller) {
            if (controller.pasteurMessages == null) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!controller.isLoading &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            controller.loadData();
                          }
                          return;
                        },
                        child: ListView.builder(
                          itemCount: controller.pasteurMessages.length,
                          itemBuilder: (context, index) {
                            return RehobotMessageCard(
                              onTap: () {
                                controller.messageScreen(
                                  id: controller.pasteurMessages[index].id,
                                );
                              },
                              title: controller.pasteurMessages[index].title,
                              summary:
                                  controller.pasteurMessages[index].summary,
                              publishedAt:
                                  controller.pasteurMessages[index].publishedAt,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: controller.isLoading ? 50.0 : 0,
                      color: Colors.transparent,
                      child: Center(
                        child: new CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
