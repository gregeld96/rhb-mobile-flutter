import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/crisis-center/criscen.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class CrisisCenterScreen extends StatelessWidget {
  final CriscenController controller = Get.put(CriscenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RehobotAppBar().indigoAppBar(
          context: context,
          onpress: () {
            Navigator.pop(context);
          },
          title: 'Rehobot Crisis Center',
        ),
        body: GetBuilder<CriscenController>(
          builder: (controller) {
            if (controller.crisisCenter == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      RehobotGeneralText(
                        title:
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      RehobotGeneralText(
                        title: 'Kontak Pelayan',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      Divider(),
                      Column(
                        children: List.generate(controller.crisisCenter.length,
                            (index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(controller
                                                  .imageAPI +
                                              '/crisis_center/${controller.crisisCenter[index].profilePic}'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.crisisCenter[index].name,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: RehobotThemes.indigoRehobot,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        controller
                                            .crisisCenter[index].phoneNumber
                                            .toString(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: RehobotThemes.indigoRehobot,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(),
                            ],
                          );
                        }),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
