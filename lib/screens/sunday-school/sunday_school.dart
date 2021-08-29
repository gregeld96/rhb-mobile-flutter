import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/sunday-school/sunday-school.dart';
import 'package:rhb_mobile_flutter/screens/sunday-school/local-widget/video.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/event_slider.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'local-widget/child_slider.dart';

class SundaySchoolScreen extends StatelessWidget {
  final SundaySchoolController controller = Get.put(SundaySchoolController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          controller.getBack(context);
        },
        title: 'Sunday School',
        context: context,
      ),
      body: GetBuilder<SundaySchoolController>(builder: (controller) {
        if (controller.video == null ||
            controller.childrenController.children == null ||
            controller.testimony == null ||
            controller.events == null) {
          return ListView(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        } else {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: controller.childrenController.children.length >
                              0
                          ? List.generate(
                              controller.childrenController.children.length + 1,
                              (index) => index ==
                                      controller
                                          .childrenController.children.length
                                  ? ChildSlider(
                                      section: 'add',
                                      onTap: () {
                                        controller.childrenController
                                            .toAddChildScreen();
                                      },
                                    )
                                  : ChildSlider(
                                      name: controller.childrenController
                                          .children[index].fullName,
                                      photo: controller.childrenController
                                          .children[index].profilePic,
                                      imageAPI: controller.imageAPI,
                                      section: '',
                                      onTap: () {
                                        controller.profileChild(
                                          id: controller.childrenController
                                              .children[index].id,
                                          index: index,
                                        );
                                      },
                                    ),
                            )
                          : [
                              ChildSlider(
                                section: 'add',
                                onTap: () {
                                  controller.childrenController
                                      .toAddChildScreen();
                                },
                              ),
                            ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Divider(
                  thickness: 1.5,
                  height: 3,
                ),
              ),
              // Video Player
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: RehobotGeneralText(
                  title: 'Kategory Kelas',
                  alignment: Alignment.centerLeft,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: EventSliderCustom(
                  section: 'sunday-school',
                  imageAPI: controller.imageAPI,
                  list: controller.events,
                  onPress: (val) {
                    controller.registerEvent(val);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                child: RehobotGeneralText(
                  title: 'Testimony',
                  alignment: Alignment.centerLeft,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.7,
                    viewportFraction: 0.9,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                  ),
                  items: controller.testimony
                      .map(
                        (item) => Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    CircleAvatar(
                                      maxRadius: 30,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          controller.imageAPI +
                                              '/testimonial/${item.photo}'),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Flexible(
                                      child: RehobotGeneralText(
                                        title: item.name,
                                        alignment: Alignment.centerLeft,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                      WidgetSpan(
                                        child: Transform.rotate(
                                            angle: 180 * math.pi / 180,
                                            child: Icon(
                                              Icons.format_quote,
                                              color: Colors.black,
                                            )),
                                      ),
                                      TextSpan(
                                        text: item.testimony,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: Icon(
                                          Icons.format_quote,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
