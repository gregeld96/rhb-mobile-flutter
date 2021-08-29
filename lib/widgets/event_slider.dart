import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/notif_board.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

typedef OnPress = void Function(int value);

class EventSliderCustom extends StatelessWidget {
  EventSliderCustom({
    @required this.list,
    @required this.imageAPI,
    @required this.section,
    @required this.onPress,
  });

  final List list;
  final String imageAPI;
  final String section;
  final OnPress onPress;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.4,
        viewportFraction: 0.85,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        initialPage: 0,
      ),
      items: list.length > 0
          ? list
              .map(
                (item) => Stack(
                  children: [
                    Positioned(
                      top: 50,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            child: section == 'home'
                                ? EventDetails(
                                    title: item.name,
                                    date: item.date,
                                    time: item.time,
                                    onpress: () {
                                      onPress(item.id);
                                    },
                                    speaker: item.pembicara.pasteur,
                                  )
                                : SundaySchoolDetails(
                                    title: item.title,
                                    category:
                                        '${item.ageMin}-${item.ageMax} tahun',
                                    date: item.day,
                                    time: item.time,
                                    quota: item.quota,
                                    register: () {
                                      onPress(item.id);
                                    },
                                    join: () {
                                      onPress(item.id);
                                    },
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width / 1.38,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          image: item.banner != ''
                              ? section == 'home'
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          imageAPI + '/banner/${item.banner}'),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(imageAPI +
                                          '/sunday-school/${item.banner}'),
                                    )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList()
          : [
              NotifBoard(
                title: 'No Events',
              )
            ],
    );
  }
}

class EventDetails extends StatelessWidget {
  EventDetails({
    @required this.title,
    @required this.date,
    @required this.time,
    @required this.speaker,
    @required this.onpress,
  });

  final String title;
  final String date;
  final String time;
  final String speaker;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RehobotGeneralText(
          title: title,
          alignment: Alignment.topLeft,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$date | $time',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Pelaksana: $speaker',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.white; // Use the component's default.
                      },
                    ),
                    elevation: MaterialStateProperty.all(3),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: onpress,
                  child: Container(
                    height: 20,
                    width: 50,
                    child: RehobotGeneralText(
                      title: 'INFO',
                      alignment: Alignment.center,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}

class SundaySchoolDetails extends StatelessWidget {
  SundaySchoolDetails({
    @required this.title,
    @required this.category,
    @required this.date,
    @required this.time,
    @required this.quota,
    this.register,
    this.join,
  });

  final String title;
  final String category;
  final String date;
  final String time;
  final String quota;
  final Function register;
  final Function join;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        RehobotGeneralText(
          title: title,
          alignment: Alignment.topLeft,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 3 : 0,
                  right:
                      index == 0 ? 0 : MediaQuery.of(context).size.width / 20,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      index == 0
                          ? 'assets/icons/profile-name-icon.svg'
                          : 'assets/icons/kuota-icon.svg',
                      height: 15,
                      width: 15,
                      color: RehobotThemes.indigoRehobot,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RehobotGeneralText(
                      title: index == 0 ? category : 'Kuota ($quota)',
                      alignment: Alignment.centerLeft,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (index) {
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      index == 0 ? 0 : MediaQuery.of(context).size.width / 20,
                ),
                child: Row(
                  children: [
                    index == 0
                        ? Icon(
                            Icons.date_range_outlined,
                            color: RehobotThemes.indigoRehobot,
                            size: 19,
                          )
                        : SvgPicture.asset(
                            'assets/icons/clock-icon.svg',
                            height: 15,
                            width: 15,
                            color: RehobotThemes.indigoRehobot,
                          ),
                    SizedBox(
                      width: 5,
                    ),
                    RehobotGeneralText(
                      title: index == 0 ? date : time,
                      alignment: Alignment.centerLeft,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (index) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.white; // Use the component's default.
                    },
                  ),
                  elevation: MaterialStateProperty.all(3),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: index == 0 ? register : join,
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width / 5,
                  child: RehobotGeneralText(
                    title: index == 0 ? 'Daftar' : 'Masuk',
                    alignment: Alignment.center,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
