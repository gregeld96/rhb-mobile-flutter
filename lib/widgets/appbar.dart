import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';

class RehobotAppBar {
  generalAppBar({
    @required Function() onpress,
    @required String title,
    BuildContext context,
  }) {
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        MediaQuery.of(context).size.height / 10,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: TextButton(
              onPressed: onpress,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: RehobotThemes.activeRehobot,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: RehobotThemes.indigoRehobot,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  indigoAppBar({
    @required Function() onpress,
    @required String title,
    BuildContext context,
  }) {
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        MediaQuery.of(context).size.height / 10,
      ),
      child: Container(
        color: RehobotThemes.indigoRehobot,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: TextButton(
                onPressed: onpress,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Icon(
                        Icons.navigate_before,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }

  indigoTextAppBar({
    @required String title,
    BuildContext context,
  }) {
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        MediaQuery.of(context).size.height / 10,
      ),
      child: Container(
        color: RehobotThemes.indigoRehobot,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
