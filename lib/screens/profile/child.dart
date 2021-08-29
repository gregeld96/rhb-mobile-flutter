import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/user/children.dart';
import 'package:rhb_mobile_flutter/helpers/date.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileChildScreen extends StatelessWidget {
  final UserChildController controller = Get.find<UserChildController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().generalAppBar(
        onpress: () {
          Get.back();
        },
        title: 'Kembali',
        context: context,
      ),
      body: GetBuilder<UserChildController>(builder: (_) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 25.0,
              ),
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
                              image: controller.childData[0].profilePic != ''
                                  ? NetworkImage(controller.imageAPI +
                                      '/child-profile-pic/${controller.childData[0].profilePic}')
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
                        title: controller.childData[0].fullName,
                        alignment: Alignment.centerLeft,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_outlined,
                            color: RehobotThemes.indigoRehobot,
                            size: 19,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RehobotGeneralText(
                            title: controller.childData[0].birthOfDate != null
                                ? DateFormat().backToFront(
                                    controller.childData[0].birthOfDate)
                                : 'No Data',
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
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 50,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RehobotButton().roundedButton(
                    title: 'Edit',
                    radius: 10,
                    context: context,
                    height: 10,
                    widthDivider: 35,
                    fontSize: 14,
                    textColor: RehobotThemes.inactiveRehobot,
                    buttonColor: RehobotThemes.activeRehobot,
                    onPressed: () {
                      controller.editSection(controller.tappedChild.value);
                    },
                  ),
                  RehobotButton().roundedButton(
                    title: 'Show QR Code',
                    radius: 10,
                    context: context,
                    height: 10,
                    widthDivider: 35,
                    fontSize: 14,
                    textColor: RehobotThemes.indigoRehobot,
                    buttonColor: Colors.white,
                    onPressed: () {
                      showQr(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          onTap: () {},
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children:
                    // controller.history.length > 0
                    //     ? List.generate(
                    //         controller.history.length > 5
                    //             ? 5
                    //             : controller.history.length, (index) {
                    //         return RehobotHistoryCard(
                    //           time: controller.history[index].time,
                    //           title: controller.history[index].title,
                    //           date: controller.history[index].date,
                    //           icon: controller.imageAPI +
                    //               '/mass/${controller.history[index].thumbnail}',
                    //           role: controller.history[index].role,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         );
                    //       })
                    //     :
                    [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Anak tidak memiliki history',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.dialog(
            CupertinoAlertDialog(
              title: Text('Mengahapus Anak'),
              content: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RehobotGeneralText(
                  title:
                      'Apakah kamu benar akan menghapus anak ini dari list ?',
                  alignment: Alignment.center,
                  alignText: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await controller.removeChild();
                      },
                      child: Text(
                        'Hapus',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        child: Container(
          height: 60,
          width: Get.context.width,
          color: Colors.redAccent,
          child: Center(
            child: Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showQr(BuildContext context) {
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
                            data: 'Testing broh',
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
                    onTap: controller.childData[0].profilePic == ''
                        ? () async {
                            await controller.getImageFromCamera();
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
                        color: controller.childData[0].profilePic == ''
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
                    onTap: controller.childData[0].profilePic == ''
                        ? () async {
                            controller.getImageFromGallery();
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
                        color: controller.childData[0].profilePic == ''
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
                    onTap: controller.childData[0].profilePic != ''
                        ? () async {
                            await controller.removeProfile();
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
                        color: controller.childData[0].profilePic != ''
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
}
