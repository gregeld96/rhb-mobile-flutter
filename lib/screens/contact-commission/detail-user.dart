import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ContactDetailScreen extends StatelessWidget {
  final UserConcomController controller = Get.find<UserConcomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        context: context,
        onpress: () {
          Navigator.pop(context);
        },
        title: 'Kembali',
      ),
      body: GetBuilder<UserConcomController>(
        builder: (controller) {
          if (controller.contactCommission == null) {
            return Container(
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: controller.carouselController,
                        options: CarouselOptions(
                          aspectRatio: 3,
                          viewportFraction: 0.5,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                          initialPage: controller.indexSelected,
                          onPageChanged: (index, reason) {
                            controller.changePage(index);
                          },
                        ),
                        items: List.generate(
                            controller.contactCommission.length, (index) {
                          return Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: CachedNetworkImage(
                                height: 100,
                                width: 100,
                                color: controller.indexSelected == index
                                    ? RehobotThemes.activeRehobot
                                    : RehobotThemes.indigoRehobot,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                imageUrl: controller.imageAPI +
                                    '/contact-commission/logo/${controller.contactCommission[index].logo}',
                              ),
                            ),
                          );
                        }),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width / 9,
                        left: MediaQuery.of(context).size.width / 6,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors
                                          .white; // Use the component's default.
                                    },
                                  ),
                                  elevation: MaterialStateProperty.all(3),
                                  shape:
                                      MaterialStateProperty.all<CircleBorder>(
                                    CircleBorder(
                                      side: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  controller.decreaseIndexPage();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 18,
                                  color: RehobotThemes.indigoRehobot,
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Colors
                                          .white; // Use the component's default.
                                    },
                                  ),
                                  elevation: MaterialStateProperty.all(3),
                                  shape:
                                      MaterialStateProperty.all<CircleBorder>(
                                    CircleBorder(
                                      side: BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  controller.increaseIndexPage();
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                  color: RehobotThemes.indigoRehobot,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Divider(
                      height: 20,
                      thickness: 2,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RehobotGeneralText(
                    title: controller
                        .contactCommission[controller.indexSelected].title,
                    alignment: Alignment.topCenter,
                    fontSize: 18,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: RehobotGeneralText(
                      title: controller
                          .contactCommission[controller.indexSelected]
                          .description,
                      alignment: Alignment.centerLeft,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RehobotGeneralText(
                    title: 'Ketua Komisi',
                    alignment: Alignment.topCenter,
                    fontSize: 18,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(controller.imageAPI +
                        '/contact-commission/leader/${controller.contactCommission[controller.indexSelected].leaderPic}'),
                    maxRadius: 50,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RehobotGeneralText(
                    title: controller
                        .contactCommission[controller.indexSelected].leaderName,
                    alignment: Alignment.topCenter,
                    fontSize: 16,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.normal,
                  ),
                  RehobotGeneralText(
                    title: controller
                        .contactCommission[controller.indexSelected]
                        .leaderPhone,
                    alignment: Alignment.topCenter,
                    fontSize: 16,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.normal,
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
