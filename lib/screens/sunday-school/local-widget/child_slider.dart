import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class ChildSlider extends StatelessWidget {
  ChildSlider({
    this.imageAPI,
    this.photo,
    this.name,
    @required this.section,
    @required this.onTap,
  });

  final String imageAPI;
  final String photo;
  final String name;
  final String section;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: section == 'add'
          ? AddChild()
          : ChildData(
              imageAPI: imageAPI,
              photo: photo,
              name: name,
            ),
    );
  }
}

class AddChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DottedBorder(
          color: RehobotThemes.indigoRehobot,
          borderType: BorderType.RRect,
          radius: Radius.circular(37.5),
          dashPattern: [6, 4],
          strokeWidth: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(37.5)),
            child: Container(
              height: MediaQuery.of(context).size.height / 10.5,
              width: MediaQuery.of(context).size.width / 5.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_sharp,
                color: RehobotThemes.indigoRehobot,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          child: RehobotGeneralText(
            title: 'add'.toUpperCase(),
            fontSize: 12,
            fontWeight: FontWeight.normal,
            alignment: Alignment.center,
            alignText: TextAlign.center,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class ChildData extends StatelessWidget {
  ChildData({
    this.imageAPI,
    this.photo,
    this.name,
  });

  final String imageAPI;
  final String photo;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: CircleBorder(),
          elevation: 3,
          child: Container(
            height: MediaQuery.of(context).size.height / 9.5,
            width: MediaQuery.of(context).size.width / 4.5,
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: photo != ''
                    ? NetworkImage(imageAPI + '/child-profile-pic/$photo')
                    : AssetImage('assets/images/man.jpeg'),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3.5,
          child: RehobotGeneralText(
            title: name.toUpperCase(),
            fontSize: 12,
            fontWeight: FontWeight.normal,
            alignment: Alignment.center,
            alignText: TextAlign.center,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
