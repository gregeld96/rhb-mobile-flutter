import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/controllers/main-tab.dart';
import 'package:rhb_mobile_flutter/screens/splash/splash.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rhb_mobile_flutter/services/onesignal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_links/uni_links.dart';

bool _initialUriIsHandled = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await OneSignalSdk().initOnsignal.then((value) async {
    await OneSignalSdk().promtUser();
  });

  await GetStorage.init('token');
  await GetStorage.init('user');

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(GskiRehobot());
}

class GskiRehobot extends StatefulWidget {
  @override
  _GskiRehobotState createState() => _GskiRehobotState();
}

class _GskiRehobotState extends State<GskiRehobot> {
  StreamSubscription sub;
  MainTabController tab = Get.find<MainTabController>();

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      sub = uriLinkStream.listen((Uri uri) {
        if (!mounted) return;
        print('lanjutan');
        print(sub);
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
      });
    }
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      Get.snackbar('info', "_handleInitialUri called");
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          var temp = "$uri".split('/');
          switch (temp[3]) {
            case 'pasteur-message':
              tab.initialStart(
                tab: 0,
                title: temp[3],
                sectionId: int.parse(temp[4]),
              );
              break;
            case 'jadwal-ibadah':
              tab.initialStart(
                tab: 0,
                title: temp[3],
                sectionId: int.parse(temp[4]),
                categoryId: int.parse(temp[6]),
              );
              break;
            default:
          }
        }
        if (!mounted) return;
      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      } on FormatException catch (err) {
        if (!mounted) return;
        print('malformed initial uri');
        print(err);
      }
    }
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    OneSignalSdk().initialize();
    _handleInitialUri();
    _handleIncomingLinks();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
