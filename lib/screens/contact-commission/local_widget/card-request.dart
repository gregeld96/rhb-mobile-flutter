import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

typedef Response = void Function(bool value);

class CardRequest extends StatelessWidget {
  CardRequest({
    @required this.title,
    @required this.time,
    @required this.date,
    @required this.location,
    @required this.section,
    @required this.role,
    @required this.approval,
    this.detailPress,
    this.responsePress,
  });

  final String title;
  final String time;
  final String date;
  final String location;
  final String role;
  final String section;
  final dynamic approval;
  final Function detailPress;
  final Response responsePress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: RehobotGeneralText(
                      title: title,
                      alignment: Alignment.centerLeft,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: detailPress,
                    child: RehobotGeneralText(
                      title: 'Lihat semua',
                      alignment: Alignment.centerRight,
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RehobotGeneralText(
                title: 'As $role',
                alignment: Alignment.centerLeft,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(2, (index) {
                  return Row(
                    children: [
                      Icon(
                        index == 0
                            ? Icons.access_time
                            : Icons.location_on_outlined,
                        color: RehobotThemes.indigoRehobot,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 120,
                        child: Text(
                          index == 0 ? time : location,
                          softWrap: true,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_sharp,
                    color: RehobotThemes.indigoRehobot,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    date,
                    softWrap: true,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              if (section == 'request' && approval == null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RehobotButton().roundedButton(
                        radius: 10,
                        title: 'Terima',
                        context: context,
                        height: 5,
                        widthDivider: Get.context.width / 15,
                        textColor: RehobotThemes.indigoRehobot,
                        buttonColor: RehobotThemes.pageRehobot,
                        onPressed: () {
                          responsePress(true);
                        },
                      ),
                      RehobotButton().roundedButton(
                        radius: 10,
                        title: 'Tolak',
                        context: context,
                        height: 5,
                        widthDivider: Get.context.width / 15,
                        textColor: RehobotThemes.indigoRehobot,
                        buttonColor: RehobotThemes.pageRehobot,
                        onPressed: () {
                          responsePress(false);
                        },
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
