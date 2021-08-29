import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class UserContactCommissionScreen extends StatelessWidget {
  final UserConcomController controller = Get.find<UserConcomController>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 175,
          crossAxisCount: 2,
        ),
        itemCount: controller.contactCommission.length,
        itemBuilder: (context, idx) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.detailScreen(idx);
                },
                child: Card(
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
                      color: RehobotThemes.indigoRehobot,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      imageUrl: controller.imageAPI +
                          '/contact-commission/logo/${controller.contactCommission[idx].logo}',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: RehobotGeneralText(
                  title: controller.contactCommission[idx].title,
                  alignment: Alignment.center,
                  alignText: TextAlign.center,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          );
        });

    // GridView.count(
    //   physics: ScrollPhysics(),
    //   crossAxisCount: 2,
    //   shrinkWrap: true,
    //   crossAxisSpacing: 10,
    //   mainAxisSpacing: 10,
    //   childAspectRatio: 0.8,
    //   children: List.generate(
    //     controller.contactCommission.length,
    //     (index) {
    //       return ListView(
    //         physics: NeverScrollableScrollPhysics(),
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               controller.detailScreen(index);
    //             },
    //             child: Card(
    //               color: Colors.white,
    //               elevation: 4,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(15),
    //                 child: CachedNetworkImage(
    //                   height: 100,
    //                   width: 100,
    //                   color: RehobotThemes.indigoRehobot,
    //                   placeholder: (context, url) =>
    //                       CircularProgressIndicator(),
    //                   imageUrl: controller.imageAPI +
    //                       '/contact-commission/logo/${controller.contactCommission[index].logo}',
    //                 ),
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 5,
    //           ),
    //           Center(
    //             child: RehobotGeneralText(
    //               title: controller.contactCommission[index].title,
    //               alignment: Alignment.center,
    //               alignText: TextAlign.center,
    //               fontSize: 16,
    //               fontWeight: FontWeight.normal,
    //             ),
    //           ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }
}
