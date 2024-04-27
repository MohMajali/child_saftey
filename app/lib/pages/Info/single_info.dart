import 'dart:developer';

import 'package:flutter/material.dart';

class SingleInfo extends StatelessWidget {
  final String appBarTitle, type;
  const SingleInfo({super.key, required this.appBarTitle, required this.type});

  @override
  Widget build(BuildContext context) {
    List images = [
      {
        "type": "1",
        "image": [
          "assets/image/photo_1.jpg",
          "assets/image/photo_2.jpg",
          "assets/image/photo_3.jpg",
          "assets/image/photo_4.jpg",
          "assets/image/photo_5.jpg",
          "assets/image/photo_6.jpg",
        ]
      },
      {
        "type": "2",
        "image": [
          "assets/image/photo_6.jpg",
          "assets/image/photo_7.jpg",
          "assets/image/photo_8.jpg",
          "assets/image/photo_9.jpg",
          "assets/image/photo_10.jpg",
          "assets/image/photo_11.jpg",
          "assets/image/photo_12.jpg",
          "assets/image/photo_13.jpg",
          "assets/image/photo_14.jpg",
          "assets/image/photo_15.jpg",
        ]
      }
    ];

    log("${images.where((element) => element['type'] == type).toList()[0]['image'].length}");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(appBarTitle)])),
          body: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                      images
                          .where((element) => element['type'] == type)
                          .toList()[0]['image']
                          .length,
                      (index) => Center(
                          child: Container(
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "${images.where((element) => element['type'] == type).toList()[0]['image'][index]}"),
                                      fit: BoxFit.contain)))))))),
    );
  }
}
