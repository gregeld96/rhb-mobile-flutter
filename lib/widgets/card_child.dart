import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnSelected = void Function(int id, bool value);

class CardChild extends StatelessWidget {
  CardChild({
    @required this.id,
    @required this.name,
    @required this.birthPlace,
    @required this.dob,
    @required this.gender,
    @required this.onlineFile,
    @required this.onpress,
    @required this.checkboxValue,
    this.viewDocument,
    this.onSelected,
  });

  final int id;
  final String name;
  final String birthPlace;
  final String dob;
  final String gender;
  final Function() onpress;
  final OnSelected onSelected;
  final String onlineFile;
  final bool checkboxValue;
  final Function() viewDocument;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        child: Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: onpress,
                      child: SvgPicture.asset(
                        'assets/icons/pencil-edit-icon.svg',
                        width: 15,
                        height: 15,
                        alignment: Alignment.centerLeft,
                        color: RehobotThemes.indigoRehobot,
                      ),
                    ),
                  ],
                ),
                Checkbox(
                  activeColor: RehobotThemes.activeRehobot,
                  checkColor: Colors.white,
                  value: checkboxValue,
                  onChanged: (val) {
                    onSelected(id, val);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location-pin-icon.svg',
                    width: 20,
                    height: 20,
                    alignment: Alignment.centerLeft,
                    color: RehobotThemes.indigoRehobot,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    birthPlace,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  2,
                  (index) {
                    return Row(
                      children: [
                        if (index != 0)
                          SvgPicture.asset(
                            'assets/icons/gender-icon.svg',
                            width: 20,
                            height: 20,
                            alignment: Alignment.centerLeft,
                            color: RehobotThemes.indigoRehobot,
                          ),
                        if (index == 0)
                          Icon(
                            Icons.calendar_today_sharp,
                            size: 18,
                            color: RehobotThemes.indigoRehobot,
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          index == 0
                              ? dob != null
                                  ? DateFormat().backToFront(dob)
                                  : ''
                              : gender,
                          softWrap: true,
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/image-upload-icon.svg',
                    width: 25,
                    height: 20,
                    alignment: Alignment.centerLeft,
                    color: RehobotThemes.indigoRehobot,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            onlineFile ?? 'Not Uploaded',
                          ),
                        ),
                        onlineFile != null
                            ? TextButton(
                                onPressed: viewDocument,
                                child: Text(
                                  'View Image',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: RehobotThemes.indigoRehobot,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
