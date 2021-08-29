import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/home/home.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/screens/pasteur-message/local_widgets/message_card.dart';
import 'package:rhb_mobile_flutter/widgets/event_slider.dart';
import 'local-widgets/news_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.quitApp();
        return;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            MediaQuery.of(context).size.height / 7,
          ),
          child: Container(
            color: RehobotThemes.indigoRehobot,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage: controller
                                      .userController.profilePic.value !=
                                  ''
                              ? NetworkImage(controller.imageAPI +
                                  '/profile_pic/${controller.userController.profilePic.value}')
                              : AssetImage('assets/images/man.jpeg'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.userController.fullName.value,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'GSKI Rehobot | 0${controller.userController.phoneNumber.value}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Text(''),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Builder(builder: (context) {
                  if (controller.news == null ||
                      controller.pasteurMessages == null ||
                      controller.incomingEvent == null ||
                      controller.pushScreen == null) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: controller.onRefresh,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: RehobotGeneralText(
                                title: 'News',
                                alignment: Alignment.centerLeft,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NewsSlider(
                              list: controller.news,
                              imageAPI: controller.imageAPI,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: RehobotGeneralText(
                                title: 'Acara yang akan datang',
                                alignment: Alignment.centerLeft,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            EventSliderCustom(
                              list: controller.incomingEvent,
                              imageAPI: controller.imageAPI,
                              section: 'home',
                              onPress: (val) {},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: 120,
                                ),
                                itemCount: controller.imageAssetPath.length,
                                itemBuilder: (context, idx) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: controller.pushScreen[idx],
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: SvgPicture.asset(
                                              controller.imageAssetPath[idx],
                                              height: 40,
                                              width: 40,
                                              alignment: Alignment.center,
                                              color:
                                                  RehobotThemes.indigoRehobot,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: RehobotGeneralText(
                                          title: controller.titleThumbnail[idx],
                                          alignment: Alignment.center,
                                          alignText: TextAlign.center,
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RehobotGeneralText(
                                    title: 'Pastor\'s Message',
                                    alignment: Alignment.centerLeft,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.pasteurScreen();
                                    },
                                    child: RehobotGeneralText(
                                      title: 'Lihat semua',
                                      alignment: Alignment.centerRight,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: Column(
                                children: controller.pasteurMessages.length > 0
                                    ? List.generate(
                                        controller.pasteurMessages.length,
                                        (index) {
                                        return RehobotMessageCard(
                                          title: controller
                                              .pasteurMessages[index].title,
                                          summary: controller
                                              .pasteurMessages[index].summary,
                                          publishedAt: controller
                                              .pasteurMessages[index]
                                              .publishedAt,
                                          onTap: () {
                                            controller.pasteur.messageScreen(
                                              id: controller
                                                  .pasteurMessages[index].id,
                                            );
                                          },
                                        );
                                      })
                                    : [
                                        Center(
                                          child: RehobotGeneralText(
                                            title:
                                                'Tidak ada bacaan untuk saat ini',
                                            alignment: Alignment.center,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
