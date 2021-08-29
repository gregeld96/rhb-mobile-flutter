import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';

class CustomShowDialog {
  openLoading() {
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text("Loading"),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  closeLoading() {
    Get.back();
  }

  loginFailed() {
    return showDialog<void>(
      context: Get.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Error'),
          content: Text('No.Handphone/Email or Password is wrong'),
          actions: [
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  userBirthday() {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Image(
        image: AssetImage('assets/images/happy-bday-img.png'),
        height: Get.context.height / 2,
        width: Get.context.width / 5,
      ),
      actions: [
        RehobotGeneralText(
          title: 'Happy Birthday!',
          alignment: Alignment.center,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
            style: TextStyle(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: ElevatedButton(
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
          ),
        )
      ],
    );
    showDialog(
      barrierDismissible: false,
      context: Get.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  generalError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  staticError() {
    Get.snackbar(
      'Error',
      'Terjadi kesalahan pada server',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
