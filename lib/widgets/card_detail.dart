import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/controllers/view_image/view.dart';
import 'package:get/get.dart';

class RehobotCardDetail extends StatefulWidget {
  RehobotCardDetail({
    @required this.name,
    @required this.birthPlace,
    @required this.dob,
    @required this.gender,
    this.occupation,
    this.address,
    this.province,
    this.city,
    this.district,
    this.subdistrict,
    this.codePost,
    this.area,
    this.phone,
    this.email,
    this.file,
    this.onlineFile,
    this.padding,
    this.edit,
    this.baptismFile,
    this.familyFile,
    this.birthFile,
    @required this.onpress,
    @required this.section,
    @required this.upload,
  });

  final String name;
  final String birthPlace;
  final String dob;
  final String gender;
  final String occupation;
  final String address;
  final String province;
  final String city;
  final String district;
  final String subdistrict;
  final String codePost;
  final String area;
  final String phone;
  final String email;
  final Function() onpress;
  final String section;
  final bool upload;
  final PickFile file;
  final PickFile birthFile;
  final PickFile familyFile;
  final PickFile baptismFile;
  final String onlineFile;
  final double padding;
  final dynamic edit;

  @override
  _RehobotCardDetailState createState() => _RehobotCardDetailState();
}

class _RehobotCardDetailState extends State<RehobotCardDetail> {
  ViewImageController controller = Get.put(ViewImageController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.padding != null ? widget.padding : 25,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              if (widget.edit == null)
                RehobotButton().iconRoundButton(
                  title: 'Edit',
                  fontSize: 14,
                  svgFile: 'assets/icons/pencil-edit-icon.svg',
                  svgColor: RehobotThemes.indigoRehobot,
                  context: context,
                  height: 5,
                  widthDivider: 15,
                  iconHeight: 15,
                  iconWidth: 15,
                  textColor: RehobotThemes.indigoRehobot,
                  buttonColor: Colors.white,
                  onPressed: widget.onpress,
                )
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
                  widget.birthPlace,
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
              children: List.generate(
                2,
                (index) {
                  return Row(
                    children: [
                      if (index == 1)
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: SvgPicture.asset(
                            'assets/icons/gender-icon.svg',
                            width: 20,
                            height: 20,
                            alignment: Alignment.centerLeft,
                            color: RehobotThemes.indigoRehobot,
                          ),
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
                        index == 0 ? widget.dob : widget.gender,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (widget.section == 'personal')
            Column(children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 24,
                    color: RehobotThemes.indigoRehobot,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      '${widget.address}, ${widget.area}, ${widget.subdistrict}, ${widget.district}, ${widget.city}, ${widget.province} ${widget.codePost}',
                    ),
                  ),
                ],
              ),
            ]),
          if (widget.section == 'personal')
            Column(children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: List.generate(
                  2,
                  (index) {
                    return Row(
                      children: [
                        if (index == 1)
                          SizedBox(
                            width: 20,
                          ),
                        SvgPicture.asset(
                          index == 0
                              ? 'assets/icons/job-icon.svg'
                              : 'assets/icons/phone-number-icon.svg',
                          width: 20,
                          height: 20,
                          alignment: Alignment.centerLeft,
                          color: RehobotThemes.indigoRehobot,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          index == 0 ? widget.occupation : widget.phone,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ]),
          if (widget.section == 'personal')
            Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/email-icon.svg',
                      width: 17,
                      height: 17,
                      alignment: Alignment.centerLeft,
                      color: RehobotThemes.indigoRehobot,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        widget.email,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          if (widget.upload)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            widget.file != null
                                ? widget.file.path.split('/').last
                                : widget.onlineFile,
                          ),
                        ),
                        widget.file != null
                            ? TextButton(
                                onPressed: () {
                                  controller.imagePage(
                                      widget.file.path, widget.file.ext);
                                },
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
          if (widget.baptismFile != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
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
                            widget.baptismFile.path.split('/').last,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.imagePage(
                              widget.baptismFile.path,
                              widget.baptismFile.ext,
                            );
                          },
                          child: Text(
                            'View Image',
                            style: TextStyle(
                              fontSize: 12,
                              color: RehobotThemes.indigoRehobot,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (widget.birthFile != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
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
                            widget.birthFile.path.split('/').last,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.imagePage(
                              widget.birthFile.path,
                              widget.birthFile.ext,
                            );
                          },
                          child: Text(
                            'View Image',
                            style: TextStyle(
                              fontSize: 12,
                              color: RehobotThemes.indigoRehobot,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          if (widget.familyFile != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
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
                            widget.familyFile.path.split('/').last,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.imagePage(
                              widget.familyFile.path,
                              widget.familyFile.ext,
                            );
                          },
                          child: Text(
                            'View Image',
                            style: TextStyle(
                              fontSize: 12,
                              color: RehobotThemes.indigoRehobot,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: 25,
          ),
          Divider(
            color: Colors.grey[400],
            height: 3,
            thickness: 2,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
