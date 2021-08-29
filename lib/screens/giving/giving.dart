import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/dynamic-screen/giving.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clipboard/clipboard.dart';

class GivingScreen extends StatelessWidget {
  final GivingController controller = Get.put(GivingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Giving',
        context: context,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GetBuilder<GivingController>(
          builder: (controller) {
            if (controller.giving == null) {
              return Container(
                width: Get.context.width,
                height: Get.context.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 25, right: 25),
                child: Column(
                  children: [
                    Text(
                      'Persembahan dapat ditransfer \n melalui rekening:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        'Bank ${controller.giving.bank}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text(
                        'A/N. ${controller.giving.holder}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FlutterClipboard.copy(
                          '${controller.giving.noRek.replaceAll(new RegExp(r"\s+\b|\b\s"), "")}',
                        ).then(
                          (value) => Get.snackbar(
                            'Success',
                            'Nomor Rekening berhasil di copy',
                            snackPosition: SnackPosition.BOTTOM,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(
                          '${controller.giving.noRek}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0, bottom: 10),
                      child: Divider(
                        height: 5,
                        thickness: 4.0,
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        imageUrl: controller.imageAPI +
                            '/giving/${controller.giving.qr}',
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
