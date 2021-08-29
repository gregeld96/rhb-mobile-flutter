import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/controllers/jadwal-ibadah/jadwal-ibadah.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class WorshipScreen extends StatelessWidget {
  final WorshipController controller = Get.find<WorshipController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: RehobotAppBar().indigoAppBar(
          context: context,
          onpress: () {
            Navigator.pop(context);
          },
          title: 'Jadwal Ibadah',
        ),
        body: SingleChildScrollView(
          child: GetBuilder<WorshipController>(
            builder: (controller) {
              if (controller.worships == null) {
                return Center(
                  heightFactor: 5,
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children:
                        List.generate(controller.worships.length, (index) {
                      return Column(
                        children: [
                          RehobotGeneralText(
                            title: controller.worships[index].title,
                            alignment: Alignment.centerLeft,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisExtent: 120,
                              ),
                              itemCount:
                                  controller.worships[index].categories.length,
                              itemBuilder: (context, idx) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.getListWorship(
                                          categoryId: controller.worships[index]
                                              .categories[idx].id,
                                          sectionId:
                                              controller.worships[index].id,
                                        );
                                      },
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Padding(
                                          padding: index == 1
                                              ? const EdgeInsets.all(10)
                                              : const EdgeInsets.all(15),
                                          child: CachedNetworkImage(
                                            height: index == 1 ? 55 : 40,
                                            width: 50,
                                            color: RehobotThemes.indigoRehobot,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            imageUrl: controller.imageAPI +
                                                '/mass/${controller.worships[index].categories[idx].thumbnail}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Center(
                                      child: RehobotGeneralText(
                                        title: controller.worships[index]
                                            .categories[idx].title,
                                        alignment: Alignment.center,
                                        alignText: TextAlign.center,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      );
                    }),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
