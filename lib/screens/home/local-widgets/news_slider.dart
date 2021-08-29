import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/widgets/notif_board.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSlider extends StatelessWidget {
  NewsSlider({@required this.list, @required this.imageAPI});

  final List list;
  final String imageAPI;

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.8,
        viewportFraction: 0.9,
        enlargeCenterPage: false,
        enableInfiniteScroll: false,
        initialPage: 0,
      ),
      items: list.length == 0
          ? [
              NotifBoard(
                title: 'No News',
              ),
            ]
          : list
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: GestureDetector(
                    onTap: item.url != null && item.url != ''
                        ? () {
                            _launchInWebViewWithJavaScript(item.url);
                          }
                        : null,
                    child: Container(
                      // width: 300,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        image: item.picture != ''
                            ? DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    imageAPI + '/news/${item.picture}'),
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}
