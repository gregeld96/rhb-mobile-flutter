import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/home/home-page.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class HomePageScreen extends StatelessWidget {
  final HomePageController controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'HOME',
        context: context,
      ),
      body: GetBuilder<HomePageController>(
        builder: (controller) {
          if (controller.hotline == null ||
              controller.home == null ||
              controller.testimony == null) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 30.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(55.0),
                        child: SvgPicture.asset(
                          'assets/icons/HOME-BIG-icon.svg',
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          color: RehobotThemes.pageRehobot,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: RehobotGeneralText(
                      title: 'Apa itu HOME?',
                      alignment: Alignment.centerLeft,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: RehobotGeneralText(
                      title:
                          'Besarnya jumlah anggota jemaat gereja yang hadir dalam pertemuan ibadah akan berdampak pada kurangnya perhatian antara aktivis dan pendeta dengan jemaat. Bahkan antara jemaat dan jemaat pun belum tentu memiliki hubungan yang baik. HOME hadir untuk memfasilitasi hal itu. Kiranya HOME dapat menjadi wadah berkomunitas yang dapat mencetak pribadi-pribadi yang menjadi seperti Kristus',
                      alignment: Alignment.centerLeft,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 30.0),
                    child: ListBody(
                      children:
                          List.generate(controller.definition.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 40.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              RehobotGeneralText(
                                title: controller.definition[index].alphabet,
                                alignment: Alignment.center,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RehobotGeneralText(
                                title: controller.definition[index].description,
                                alignment: Alignment.center,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: RehobotGeneralText(
                      title: 'Testimonial',
                      alignment: Alignment.centerLeft,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.6,
                        viewportFraction: 0.85,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: RehobotGeneralText(
                      title: 'HOME Dimana Aja?',
                      alignment: Alignment.centerLeft,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: ListBody(
                      children: List.generate(controller.home.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: RehobotGeneralText(
                            title:
                                '${index + 1}\.   Home ${controller.home[index].area}: ${controller.home[index].day}, ${controller.home[index].time} (${controller.home[index].section})',
                            alignment: Alignment.centerLeft,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: RehobotGeneralText(
                      title: 'Bagaimana Bergabung di HOME?',
                      alignment: Alignment.centerLeft,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30.0),
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: SvgPicture.asset(
                              'assets/icons/call-home-icon.svg',
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              color: RehobotThemes.indigoRehobot,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RehobotGeneralText(
                                title: 'Hubungi ${controller.hotline.hotline}',
                                alignment: Alignment.centerLeft,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RehobotGeneralText(
                                title: 'Home Care RYC',
                                alignment: Alignment.centerLeft,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
