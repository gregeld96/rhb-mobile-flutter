import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:get/get.dart';

class EventCard extends StatelessWidget {
  EventCard({
    @required this.name,
    @required this.date,
    @required this.time,
    @required this.pic,
    this.quota,
    @required this.section,
    this.onPress,
    this.status,
  });

  final String name;
  final String date;
  final String time;
  final String pic;
  final String quota;
  final String section;
  final dynamic status;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Row(
          mainAxisAlignment: section != 'non'
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.start,
          children: [
            Container(
              width: section != 'non'
                  ? Get.context.width / 1.7
                  : Get.context.width / 1.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: RehobotGeneralText(
                      title: name,
                      alignment: Alignment.topLeft,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: RehobotGeneralText(
                      title: pic != null ? 'Pelaksana: $pic' : '',
                      alignment: Alignment.centerLeft,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  if (section != 'non')
                    RehobotGeneralText(
                      title: 'Quota: $quota',
                      alignment: Alignment.centerLeft,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  RehobotGeneralText(
                    title: '$date | $time',
                    alignment: Alignment.centerLeft,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  if (section == 'non')
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 125,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: status == true
                                    ? RehobotThemes.indigoRehobot
                                    : status == false
                                        ? Colors.red
                                        : Colors.orange[900],
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 10.0,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    status == true
                                        ? Icons.check_circle_outline
                                        : status == false
                                            ? Icons.cancel_outlined
                                            : Icons.access_time,
                                    color: status == true
                                        ? RehobotThemes.indigoRehobot
                                        : status == false
                                            ? Colors.red
                                            : Colors.orange[900],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: RehobotGeneralText(
                                      title: status == true
                                          ? 'accepted'.toUpperCase()
                                          : status == false
                                              ? 'rejected'.toUpperCase()
                                              : 'in review'.toUpperCase(),
                                      alignment: Alignment.center,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: status == true
                                          ? RehobotThemes.indigoRehobot
                                          : status == false
                                              ? Colors.red
                                              : Colors.orange[900],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          RehobotGeneralText(
                            title: status == true
                                ? 'Pengajuan di terima'
                                : status == false
                                    ? 'Pengajuan ditolak'
                                    : 'Pengajuan sedang di review',
                            alignment: Alignment.centerRight,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
            if (section != 'non')
              RehobotButton().roundedButton(
                title: 'Daftar',
                context: context,
                height: 5,
                widthDivider: 10,
                fontSize: 12,
                textColor: RehobotThemes.inactiveRehobot,
                buttonColor: RehobotThemes.activeRehobot,
                onPressed: onPress,
              ),
          ],
        ),
      ),
    );
  }
}
