import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/parish/tab.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ParishTab extends StatelessWidget {
  final ParishTabController controller = Get.put(ParishTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Jadwal Pelayanan Jemaat',
        context: context,
      ),
      body: GetBuilder<ParishTabController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 20,
              right: 20,
            ),
            child: Column(
              children: [
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 150,
                  ),
                  itemCount: _.tabs('icon-active').length,
                  itemBuilder: (context, idx) {
                    return GestureDetector(
                      onTap: () {
                        _.changeTab(idx);
                      },
                      child: Column(
                        children: [
                          Card(
                            color: _.currentIndex.value == idx
                                ? RehobotThemes.activeRehobot
                                : Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: idx == 0
                                  ? EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    )
                                  : EdgeInsets.all(15),
                              child: SvgPicture.asset(
                                _.currentIndex.value == idx
                                    ? _.tabs('icon-active')[idx]
                                    : _.tabs('icon')[idx],
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                color: _.currentIndex.value == idx
                                    ? Colors.white
                                    : RehobotThemes.indigoRehobot,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RehobotGeneralText(
                            title: _.tabs('section')[idx],
                            alignment: Alignment.center,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            alignText: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Divider(
                  thickness: 1.5,
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: GetBuilder<ParishTabController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Container(
            height: Get.context.height - 275,
            child: controller.tabs('route')[controller.currentIndex.value],
          ),
        );
      }),
    );
  }
}
