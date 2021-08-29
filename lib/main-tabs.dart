import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RehobotMainTabs extends StatefulWidget {
  @override
  _RehobotMainTabsState createState() => _RehobotMainTabsState();
}

class _RehobotMainTabsState extends State<RehobotMainTabs> {
  final MainTabController controller = Get.put(MainTabController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainTabController>(
      builder: (controller) {
        return Scaffold(
          body: controller.tabs('route')[controller.currentIndex.value],
          bottomNavigationBar: controller.show
              ? Container(
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      controller.tabs('icon').length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.changeTab(index);
                          },
                          child: index == 2
                              ? StreamBuilder(
                                  stream: controller.chatRef
                                      .orderBy('sentAt', descending: false)
                                      .limitToLast(30)
                                      .snapshots(),
                                  builder: (context, snapshoot) {
                                    if (snapshoot.hasData) {
                                      if (snapshoot == null) {
                                        return generalTab(controller, index);
                                      } else {
                                        return GetBuilder<MainTabController>(
                                          id: 'chat-tab',
                                          builder: (_) {
                                            _.listMessage(snapshoot.data.docs);
                                            return chatWithNotif(
                                                controller, index);
                                          },
                                        );
                                      }
                                    } else {
                                      return generalTab(controller, index);
                                    }
                                  },
                                )
                              : generalTab(controller, index),
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(),
        );
      },
    );
  }

  Column generalTab(MainTabController controller, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          controller.tabs('icon')[index],
          height: 30,
          width: 30,
          alignment: Alignment.center,
          color: controller.currentIndex.value == index
              ? RehobotThemes.indigoRehobot
              : Colors.grey,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          controller.tabs('title')[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: controller.currentIndex.value == index
                ? RehobotThemes.indigoRehobot
                : Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }

  Container chatWithNotif(MainTabController controller, int index) {
    return Container(
      height: 60,
      width: 50,
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 10,
            child: SvgPicture.asset(
              controller.tabs('icon')[index],
              height: 35,
              width: 35,
              alignment: Alignment.center,
              color: controller.currentIndex.value == index
                  ? RehobotThemes.indigoRehobot
                  : Colors.grey,
            ),
          ),
          Positioned(
            top: 40,
            left: 5,
            child: Text(
              controller.tabs('title')[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: controller.currentIndex.value == index
                    ? RehobotThemes.indigoRehobot
                    : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          if (controller.unread > 0)
            Positioned(
              top: 2,
              left: 30,
              child: Icon(
                Icons.error,
                color: Colors.red,
                size: 20,
              ),
            )
        ],
      ),
    );
  }
}
