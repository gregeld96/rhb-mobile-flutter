import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/profile/profile.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/history_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        controller.tab.backToHome();
        return;
      },
      child: Scaffold(
        appBar: RehobotAppBar().indigoTextAppBar(
          title: 'Profile',
          context: context,
        ),
        body: GetBuilder<ProfileController>(
          builder: (controller) {
            if (controller.history == null) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      profileHeader(controller, context),
                      Divider(
                        height: 2,
                        thickness: 2,
                      ),
                      cardProfile(context, controller),
                      qrCode(controller, context),
                      Divider(
                        height: 5,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      userInfo(controller),
                      SizedBox(
                        height: 40,
                      ),
                      headerHistory(controller),
                      historyContent(controller),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Padding historyContent(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: controller.history.length > 0
            ? List.generate(
                controller.history.length > 5 ? 5 : controller.history.length,
                (index) {
                return RehobotHistoryCard(
                  time: controller.history[index].time,
                  title: controller.history[index].title,
                  date: controller.history[index].date,
                  icon: controller.imageAPI +
                      '/mass/${controller.history[index].thumbnail}',
                  role: controller.history[index].role,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                );
              })
            : [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        'Kamu tidak memiliki history',
                      ),
                    ),
                  ),
                ),
              ],
      ),
    );
  }

  Padding headerHistory(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                RehobotGeneralText(
                  title: 'History',
                  alignment: Alignment.centerLeft,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {
                    controller.goHistoryUser();
                  },
                  child: RehobotGeneralText(
                    title: 'Lihat semua',
                    alignment: Alignment.centerRight,
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 5,
            thickness: 2,
          )
        ],
      ),
    );
  }

  ListBody userInfo(ProfileController controller) {
    return ListBody(
      children: [
        contact(
          title: 'Nama',
          asset: 'assets/icons/profile-name-icon.svg',
          contain: controller.user.fullName.value,
        ),
        SizedBox(
          height: 10,
        ),
        contact(
          title: 'No. Handphone',
          asset: 'assets/icons/profile-phone-icon.svg',
          contain: '0${controller.user.phoneNumber.value}',
        ),
        SizedBox(
          height: 10,
        ),
        contact(
          title: 'Email',
          asset: 'assets/icons/profile-email-icon.svg',
          contain: controller.user.email.value,
          section: 'email',
        ),
      ],
    );
  }

  Padding qrCode(ProfileController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: controller.user.isVerified.value
          ? RehobotButton().roundedButton(
              title: 'Show QR Code',
              radius: 10,
              context: context,
              height: 10,
              widthDivider: 35,
              fontSize: 14,
              textColor: RehobotThemes.indigoRehobot,
              buttonColor: Colors.white,
              onPressed: () {
                showQr(context, controller);
              },
            )
          : Container(),
    );
  }

  Padding cardProfile(BuildContext context, ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width / 1.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          image: new DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/backgrounds/card.png'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                alignment: Alignment.topLeft,
                height: 25,
                width: 100,
                image: AssetImage('assets/images/GSKI-REHOBOT-LOGO.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'MEMBERSHIP CARD',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: RehobotThemes.goldRehobot,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.user.fullName.value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RehobotThemes.goldRehobot,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    controller.user.phoneNumber.value,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: RehobotThemes.goldRehobot,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding profileHeader(ProfileController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Stack(
            children: [
              Card(
                shape: CircleBorder(),
                elevation: 3,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: controller.user.profilePic.value != ''
                          ? NetworkImage(controller.imageAPI +
                              '/profile_pic/${controller.user.profilePic.value}')
                          : AssetImage('assets/images/man.jpeg'),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 65,
                left: 65,
                child: GestureDetector(
                  onTap: () {
                    openProfileMenu(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RehobotGeneralText(
                title: controller.user.fullName.value,
                alignment: Alignment.centerLeft,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  RehobotGeneralText(
                    title:
                        'GSKI Rehobot | ${controller.user.phoneNumber.value}',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Future showQr(BuildContext context, ProfileController controller) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 3,
                  width: 40,
                  decoration: ShapeDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: RehobotGeneralText(
                    title: 'QR Code',
                    alignment: Alignment.center,
                    alignText: TextAlign.center,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1.5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2.1,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Card(
                          elevation: 3,
                          child: QrImage(
                            padding: const EdgeInsets.all(25),
                            size: 250,
                            data: controller.user.memberId,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Text(
                          'Tunjukan QR Code ini untuk mengikuti event yang akan berlangsung',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RehobotButton().roundedButton(
                          title: 'Tutup',
                          context: context,
                          radius: 10,
                          height: 10,
                          widthDivider: 25,
                          textColor: RehobotThemes.indigoRehobot,
                          buttonColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Future openProfileMenu(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 3,
                    width: 40,
                    decoration: ShapeDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Change Profile Picture',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                  ),
                  GestureDetector(
                    onTap: controller.user.profilePic.value == ''
                        ? () async {
                            await controller.user.getImageFromCamera();
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RehobotGeneralText(
                        title: 'Take Photo',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: controller.user.profilePic.value == ''
                            ? null
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                  ),
                  GestureDetector(
                    onTap: controller.user.profilePic.value == ''
                        ? () async {
                            controller.user.getImageFromGallery();
                            Navigator.pop(context);
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RehobotGeneralText(
                        title: 'Open Gallery',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: controller.user.profilePic.value == ''
                            ? null
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                  ),
                  GestureDetector(
                    onTap: controller.user.profilePic.value != ''
                        ? () async {
                            await controller.user.removeProfile();
                            Navigator.pop(context);
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RehobotGeneralText(
                        title: 'Remove Profile Picture',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: controller.user.profilePic.value != ''
                            ? null
                            : Colors.grey[400],
                      ),
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RehobotGeneralText(
                        title: 'Cancel',
                        alignment: Alignment.center,
                        alignText: TextAlign.center,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Row contact({String asset, String title, String contain, String section}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            asset,
            height: section == 'email' ? 18 : 25,
            width: section == 'email' ? 18 : 25,
            alignment: Alignment.center,
            color: RehobotThemes.indigoRehobot,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              contain,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}
