import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:get/get.dart';

class SuccessHeadline extends StatelessWidget {
  SuccessHeadline({
    @required this.userFullName,
    @required this.section,
    @required this.description,
  });

  final String userFullName;
  final String section;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(
            section == 'pembaptisan'
                ? 'assets/images/baptis-registration-registration-complete-img.png'
                : section == 'penyerahan anak'
                    ? 'assets/images/penyerahan-anak-registration-complete-img.png'
                    : 'assets/images/pranikah-registration-complete-img.png',
          ),
          width: Get.context.width / 2,
        ),
        RehobotGeneralText(
          title: 'Shallom, $userFullName',
          alignment: Alignment.center,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 5.0,
          ),
          child: RehobotGeneralText(
            title: description,
            alignment: Alignment.center,
            alignText: TextAlign.center,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Divider(
          height: 1.5,
          thickness: 2,
          color: Colors.grey[400],
        ),
      ],
    );
  }
}
