import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController controller = Get.put(SplashController());

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage('assets/backgrounds/splash.png'),
          alignment: Alignment.center,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          child: Container(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              alignment: Alignment.center,
            ),
            margin: EdgeInsets.only(top: 100),
          ),
        ),
      ],
    );
  }
}
