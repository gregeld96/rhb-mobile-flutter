import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/introduction/introduction.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class IntroductionScreen extends StatelessWidget {
  final IntroductionController controller = Get.put(IntroductionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetBuilder<IntroductionController>(
          builder: (_) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(70),
                child: Builder(builder: (context) {
                  if (_.intro == null || _.imageNetwork == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          _.imageNetwork[_.indexPage.value],
                          SizedBox(
                            height: 50,
                          ),
                          RehobotGeneralText(
                            title: _.titlePage(),
                            alignment: Alignment.center,
                            alignText: TextAlign.center,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RehobotGeneralText(
                            title: '${_.intro[_.indexPage.value].description}',
                            alignment: Alignment.center,
                            alignText: TextAlign.center,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RehobotButton().roundedButton(
                            title: _.buttonText(),
                            context: context,
                            height: 15,
                            widthDivider: 20,
                            textColor: Colors.white,
                            buttonColor: RehobotThemes.activeRehobot,
                            onPressed: () {
                              _.increment();
                            },
                          ),
                          // Column(
                          //   children: List.generate(_.intro.length, (index) {
                          //     return CachedNetworkImage(
                          //       placeholder: (context, url) =>
                          //           CircularProgressIndicator(),
                          //       imageUrl: _.imageAPI +
                          //           '/flash-page/${_.intro[index].image}',
                          //     );
                          //   }),
                          // )
                        ],
                      ),
                    );
                  }
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
