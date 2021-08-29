import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/screens/contact-commission/concom-service.dart';
import 'package:rhb_mobile_flutter/screens/contact-commission/concom-user.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/contact-commission/concom.dart';

class ContactCommissionScreen extends StatefulWidget {
  @override
  _ContactCommissionScreenState createState() =>
      _ContactCommissionScreenState();
}

class _ContactCommissionScreenState extends State<ContactCommissionScreen> {
  final UserConcomController controller = Get.put(UserConcomController());

  @override
  void didUpdateWidget(ContactCommissionScreen oldWidget) async {
    controller.user.roles > 0
        ? controller.service.getData()
        : await controller.getConcom();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        context: context,
        onpress: () {
          Get.back();
        },
        title: 'PIC Kontak Komisi',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GetBuilder<UserConcomController>(
          builder: (_) {
            if (controller.user.roles < 1) {
              if (controller.contactCommission == null) {
                return Container(
                  width: Get.context.width,
                  height: Get.context.height,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return UserContactCommissionScreen();
              }
            } else {
              return ServiceContactCommissionScreen();
            }
          },
        ),
      ),
    );
  }
}
