import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/screens/chat/index.dart';
import 'package:rhb_mobile_flutter/screens/home/home.dart';
import 'package:rhb_mobile_flutter/screens/profile/user.dart';
import 'package:rhb_mobile_flutter/screens/setting/setting.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:get/get.dart';

class CustomBottomNav extends StatelessWidget {
  CustomBottomNav({
    this.currentIndex,
  });

  final int currentIndex;
  List<dynamic> tabs(String section) {
    if (section == 'function') {
      return [
        () {
          Get.to(
            HomeScreen(),
          );
        },
        () {
          Get.to(
            ProfileScreen(),
          );
        },
        () {
          Get.to(
            ChatScreen(),
          );
        },
        () {
          Get.to(
            SettingScreen(),
          );
        },
      ];
    } else if (section == 'icon') {
      return [
        'assets/icons/home-address-icon.svg',
        'assets/icons/profile-inactive-icon.svg',
        'assets/icons/livechat-inactive-icon.svg',
        'assets/icons/setting-inactive-icon.svg',
      ];
    } else {
      return [
        'Home',
        'Profile',
        'Livechat',
        'Setting',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          tabs('icon').length,
          (index) {
            return GestureDetector(
              onTap: currentIndex != index ? tabs('function')[index] : () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    tabs('icon')[index],
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    color: currentIndex == index
                        ? RehobotThemes.indigoRehobot
                        : Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    tabs('title')[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentIndex == index
                          ? RehobotThemes.indigoRehobot
                          : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
