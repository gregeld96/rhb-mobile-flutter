import 'dart:io';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/api.dart';
import 'package:rhb_mobile_flutter/controllers/jadwal-ibadah/jadwal-ibadah.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/controllers/pasteur-message/pasteur-message.dart';
import 'package:rhb_mobile_flutter/controllers/user/user.dart';
import 'package:rhb_mobile_flutter/helpers/birthdate.dart';
import 'package:rhb_mobile_flutter/models/error.dart';
import 'package:rhb_mobile_flutter/screens/chat/index.dart';
import 'package:rhb_mobile_flutter/screens/contact-commission/concom-base.dart';
import 'package:rhb_mobile_flutter/screens/home/home-page.dart';
import 'package:rhb_mobile_flutter/screens/jadwal-ibadah/jadwal.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/pasteur-message.dart';
import 'package:rhb_mobile_flutter/models/dynamic-screen/news.dart';
import 'package:rhb_mobile_flutter/screens/news/news.dart';
import 'package:rhb_mobile_flutter/screens/parish-service/parish-tab.dart';
import 'package:rhb_mobile_flutter/screens/pasteur-message/pasteur.dart';
import 'package:rhb_mobile_flutter/screens/crisis-center/crisis-center.dart';
import 'package:rhb_mobile_flutter/screens/giving/giving.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/screens/sunday-school/sunday_school.dart';
import 'package:rhb_mobile_flutter/utils/error.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/models/worship/schedule.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/widgets/show_dialog.dart';

class HomeController extends GetxController {
  List<PasteurMessage> pasteurMessages;
  List<News> news;
  List<Schedule> incomingEvent;
  String imageAPI = RestApiController.publicImageAPI;
  CarouselController carouselController = CarouselController();
  var sliderPopIndex = 0.obs;

  UserController userController = Get.find<UserController>();
  WorshipController controller = Get.put(WorshipController());
  RestApiController api = Get.find<RestApiController>();
  MainTabController tab = Get.find<MainTabController>();
  PasteurMessageController pasteur = Get.put(PasteurMessageController());

  List<String> imageAssetPath = [
    'assets/icons/worship-schedule-icon.svg',
    'assets/icons/kuota-icon.svg',
    'assets/icons/HOME-icon.svg',
    'assets/icons/PIC-Comission-contanct.svg',
    'assets/icons/sunday-school-icon.svg',
    'assets/icons/news-icon.svg',
    'assets/icons/rehobot-crisis-center.svg',
    'assets/icons/giving-icon.svg'
  ];

  List<String> titleThumbnail = [
    'Jadwal Ibadah',
    'Jadwal Pelayanan Jemaat',
    'HOME',
    'PIC Kontak Komisi',
    'Sunday School',
    'News',
    'Rehobot Crisis Center',
    'Giving'
  ];

  List<Function> pushScreen = [
    () {
      Get.to(WorshipScreen());
    },
    () {
      Get.to(ParishTab());
    },
    () {
      Get.to(HomePageScreen());
    },
    () {
      Get.to(ContactCommissionScreen());
    },
    () {
      Get.to(SundaySchoolScreen());
    },
    () {
      Get.to(NewsScreen());
    },
    () {
      Get.to(CrisisCenterScreen());
    },
    () {
      Get.to(GivingScreen());
    }
  ];

  void onInit() async {
    await initial();
    if (tab.initial != null) {
      switch (tab.initial) {
        case 'chat':
          Get.to(ChatScreen());
          tab.changeStart();
          break;
        case 'pasteur-message':
          pasteur.messageScreen(id: tab.idSelected);
          tab.changeStart();
          break;
        case 'jadwal-ibadah':
          controller.getListWorship(
            sectionId: tab.idSelected,
            categoryId: tab.categorySelected,
          );
          tab.changeStart();
          break;
        default:
      }
    } else {
      birthday();
      await getOnGoingEvent();
      tab.changeStart();
    }
    super.onInit();
    ever(userController.profilePic, (value) {
      update();
    });
    ever(userController.fullName, (value) {
      update();
    });
    ever(tab.currentIndex, (value) async {
      if (tab.currentIndex.value == 0) {
        await initial();
        await getOnGoingEvent();
        update();
      }
    });
  }

  Future<bool> quitApp() {
    AlertDialog logout = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      title: Center(
        child: RehobotGeneralText(
          fontSize: 18,
          title: 'Quit',
          fontWeight: FontWeight.bold,
          alignText: TextAlign.center,
          color: Colors.black,
          alignment: Alignment.center,
        ),
      ),
      content: Container(
        height: 25,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: RehobotGeneralText(
          fontSize: 14,
          title: 'Are sure want to quit ?',
          fontWeight: FontWeight.normal,
          alignText: TextAlign.center,
          color: Colors.black,
          alignment: Alignment.center,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RehobotButton().roundedButton(
              radius: 15,
              title: 'No',
              context: Get.context,
              height: 5,
              widthDivider: Get.context.size.width / 20,
              textColor: Colors.black,
              buttonColor: Colors.white,
              onPressed: () {
                Get.back();
              },
            ),
            RehobotButton().roundedButton(
              radius: 15,
              title: 'Yes',
              context: Get.context,
              height: 5,
              widthDivider: Get.context.size.width / 20,
              textColor: Colors.black,
              buttonColor: Colors.white,
              onPressed: () async {
                exit(0);
              },
            )
          ],
        ),
      ],
    );
    return showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        return logout;
      },
    );
  }

  Future<void> onRefresh() async {
    try {
      await initial();
      userController.getPersonalData();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          switch (e.message) {
            case 'jwt expired':
              ErrorController().tokenError(error: e);
              break;
            case 'Connection Timeout':
              CustomShowDialog().generalError(e.message);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  Future<void> initial() async {
    try {
      await Future.delayed(Duration(milliseconds: 100));

      var newsRest = await api.dynamicContent(
        '/news?section=home',
      );
      var pasteurRest = await api.dynamicContent(
        '/shepherd-letters?limit=3&start=0',
      );
      incomingEvent = await api.schedules(
        '/incoming-events',
      );

      NewsResModel newsData = NewsResModel.fromJson(
        newsRest,
      );
      PasteurMessageResModel pasteurData = PasteurMessageResModel.fromJson(
        pasteurRest,
      );

      pasteurMessages = pasteurData.data;
      news = newsData.data.news;

      update();
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().generalError(e.message);
          break;
        default:
          switch (e.message) {
            case 'jwt expired':
              ErrorController().tokenError(error: e);
              break;
            case 'Connection Timeout':
              CustomShowDialog().generalError(e.message);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }

  void pasteurScreen() {
    Get.to(PasteurMessageScreen());
  }

  void birthday() {
    bool result = UserHelper().getCurrentDate(
      userController.userBirthday.value,
    );

    if (result) {
      CustomShowDialog().userBirthday();
    }
  }

  Future getOnGoingEvent() async {
    try {
      List<Schedule> scheduleList = await api.schedules('/ongoing-event');

      if (scheduleList.length > 0) {
        Get.dialog(
          AlertDialog(
            actionsPadding: const EdgeInsets.symmetric(horizontal: 100),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: RehobotGeneralText(
              title: 'Sedang Berlangsung',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              alignment: Alignment.center,
            ),
            content: Container(
              alignment: Alignment.center,
              height: 180,
              width: 480,
              child: Stack(
                children: [
                  Positioned(
                    top: Get.context.width / 9,
                    left: Get.context.width / 6,
                    child: Container(
                      width: Get.context.width / 1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors
                                      .white; // Use the component's default.
                                },
                              ),
                              elevation: sliderPopIndex.value != 0
                                  ? MaterialStateProperty.all(3)
                                  : MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                CircleBorder(
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed: sliderPopIndex.value != 0
                                ? () {
                                    carouselController.previousPage();
                                  }
                                : null,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: sliderPopIndex.value != 0
                                  ? RehobotThemes.indigoRehobot
                                  : Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Colors
                                      .white; // Use the component's default.
                                },
                              ),
                              elevation: sliderPopIndex.value !=
                                      scheduleList.length - 1
                                  ? MaterialStateProperty.all(3)
                                  : MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all<CircleBorder>(
                                CircleBorder(
                                  side: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            onPressed:
                                sliderPopIndex.value != scheduleList.length - 1
                                    ? () {
                                        carouselController.nextPage();
                                      }
                                    : null,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: sliderPopIndex.value !=
                                      scheduleList.length - 1
                                  ? RehobotThemes.indigoRehobot
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      aspectRatio: 1.4,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      initialPage: sliderPopIndex.value,
                      onPageChanged: (index, reason) {
                        sliderPopIndex.value = index;
                      },
                    ),
                    items: List.generate(
                      scheduleList.length,
                      (index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, //Space between kalo tombol ikut
                              children: [
                                Card(
                                  shape: CircleBorder(),
                                  elevation: 3,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(imageAPI +
                                            '/mass/${scheduleList[index].banner}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: RehobotGeneralText(
                                title: scheduleList[index].name,
                                alignment: Alignment.center,
                                fontSize: 14,
                                alignText: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/pastor-icon.svg',
                                  height: 15,
                                  width: 15,
                                  alignment: Alignment.center,
                                  color: RehobotThemes.indigoRehobot,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  scheduleList[index].pembicara.pasteur,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/clock-icon.svg',
                                      height: 10,
                                      width: 10,
                                      alignment: Alignment.center,
                                      color: RehobotThemes.indigoRehobot,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      scheduleList[index].time,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_sharp,
                                      size: 12,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      scheduleList[index].date,
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location-pin-icon.svg',
                                      height: 10,
                                      width: 10,
                                      alignment: Alignment.center,
                                      color: RehobotThemes.indigoRehobot,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      scheduleList[index].location != ''
                                          ? scheduleList[index].location
                                          : 'TBA',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:
                                  List.generate(scheduleList.length, (index) {
                                return Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color:
                                        // sliderPopIndex.value == index
                                        //     ? RehobotThemes.indigoRehobot
                                        //     :
                                        Color.fromRGBO(0, 0, 0, 0.4),
                                    shape: BoxShape.rectangle,
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
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
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  height: 40,
                  width: 100,
                  child: RehobotGeneralText(
                    title: 'Tutup',
                    alignment: Alignment.center,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } on ErrorResModel catch (e) {
      switch (e.statusCode) {
        case 401:
          ErrorController().tokenError(error: e);
          break;
        case 400:
          CustomShowDialog().loginFailed();
          break;
        default:
          switch (e.message) {
            case 'jwt expired':
              ErrorController().tokenError(error: e);
              break;
            case 'Connection Timeout':
              CustomShowDialog().generalError(e.message);
              break;
            default:
              CustomShowDialog().staticError();
          }
      }
    }
  }
}
