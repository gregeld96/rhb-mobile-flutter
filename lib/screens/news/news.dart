import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/controllers/dynamic-screen/news.dart';
import 'package:rhb_mobile_flutter/widgets/appbar.dart';

class NewsScreen extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RehobotAppBar().indigoAppBar(
        onpress: () {
          Get.back();
        },
        title: 'News',
        context: context,
      ),
      body: GetBuilder<NewsController>(
        builder: (controller) {
          if (controller.news == null) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          aspectRatio: 1.1,
                          viewportFraction: 1,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: true,
                          initialPage: 0,
                          onPageChanged: (index, reason) {
                            controller.carouselChange(index);
                          }),
                      items: List.generate(controller.news.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.detailNews(
                              picture: controller.news[index].picture,
                              description: controller.news[index].description,
                              url: controller.news[index].url,
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(controller.imageAPI +
                                    '/news/${controller.news[index].picture}'),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(controller.news.length,
                                  (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 5,
                                  ),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.indigo),
                                      color: controller.currentIndex == index
                                          ? Colors.white
                                          : Color.fromRGBO(0, 0, 0, 0.4),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      shrinkWrap: true,
                      children: List.generate(controller.news.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.detailNews(
                              picture: controller.news[index].picture,
                              description: controller.news[index].description,
                              url: controller.news[index].url,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(controller.imageAPI +
                                    '/news/${controller.news[index].picture}'),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
