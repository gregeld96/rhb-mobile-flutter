import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/jadwal-ibadah/jadwal-ibadah.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:share/share.dart';

class DetailWorshipScreen extends StatelessWidget {
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: GetBuilder<WorshipController>(
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200, //120
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: CachedNetworkImage(
                                height: 75,
                                width: 70,
                                color: RehobotThemes.indigoRehobot,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                imageUrl: controller.imageAPI +
                                    '/mass/${controller.thumbnail}',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                RehobotGeneralText(
                                  title: controller.title,
                                  alignment: Alignment.topLeft,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: RehobotGeneralText(
                                    title: controller.description,
                                    alignment: Alignment.centerLeft,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                      height: 10,
                      thickness: 1.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: CheckboxListTile(
                        title: RehobotGeneralText(
                          title: 'Pilih Semuanya',
                          alignment: Alignment.centerRight,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: controller.clickEvery,
                        onChanged: controller.list.length > 0
                            ? (val) {
                                controller.changeEvery();
                                openMenu(
                                  context,
                                  null,
                                );
                              }
                            : null,
                        activeColor: RehobotThemes.activeRehobot,
                        checkColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: List.generate(controller.list.length, (index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: CheckboxListTile(
                              title: Column(
                                children: [
                                  RehobotGeneralText(
                                    title: controller.list[index].name,
                                    alignment: Alignment.topLeft,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  RehobotGeneralText(
                                    title:
                                        'Pelaksana: ${controller.list[index].pembicara.pasteur}',
                                    alignment: Alignment.centerLeft,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  RehobotGeneralText(
                                    title:
                                        '${controller.list[index].date} | ${controller.list[index].time}',
                                    alignment: Alignment.centerLeft,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  )
                                ],
                              ),
                              value: controller.list[index].status,
                              onChanged: (val) {
                                controller.list[index].status == false
                                    ? openMenu(
                                        context,
                                        index,
                                      )
                                    : controller.checkItem(
                                        index: index,
                                      );
                              },
                              activeColor: RehobotThemes.activeRehobot,
                              checkColor: Colors.white,
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future openMenu(
    BuildContext context,
    dynamic index,
  ) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 190,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 3,
                    width: 40,
                    decoration: ShapeDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Pilih',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RehobotButton().roundedButton(
                          radius: 5,
                          title: 'Ingatkan Saya',
                          context: context,
                          height: 10,
                          widthDivider: 35,
                          fontWeight: false,
                          textColor: RehobotThemes.indigoRehobot,
                          buttonColor: RehobotThemes.pageRehobot,
                          onPressed: () {
                            controller.checkItem(
                              index: index != null ? index : null,
                            );
                            Get.back();
                          },
                        ),
                        RehobotButton().roundedButton(
                          radius: 5,
                          title: 'Share',
                          context: context,
                          height: 10,
                          widthDivider: 35,
                          fontWeight: false,
                          textColor: RehobotThemes.indigoRehobot,
                          buttonColor: RehobotThemes.pageRehobot,
                          onPressed: () {
                            final RenderBox box = context.findRenderObject();
                            Share.share(
                              index != null
                                  ? controller.url +
                                      '/${controller.list[index].name.replaceAll(new RegExp(r"\s+\b|\b\s"), "-")}'
                                  : controller.url,
                              sharePositionOrigin:
                                  box.localToGlobal(Offset.zero) & box.size,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RehobotGeneralText(
                        title: 'Cancel',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
