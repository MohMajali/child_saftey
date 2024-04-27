import 'package:ecommerce/pages/Info/single_info.dart';
import 'package:ecommerce/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
                title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("ثقف نفسك")])),
            body: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SingleInfo(
                                appBarTitle: "العنف", type: "1"))),
                    child: const ItemWidget2(
                      image:
                          "https://modo3.com/thumbs/fit630x300/113668/1592414895/%D8%A2%D8%AB%D8%A7%D8%B1_%D8%A7%D9%84%D8%B9%D9%86%D9%81_%D8%B6%D8%AF_%D8%A7%D9%84%D9%85%D8%B1%D8%A3%D8%A9.jpg",
                      title: "العنف",
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SingleInfo(
                                appBarTitle: "العنف", type: "2"))),
                    child: const ItemWidget2(
                      image:
                          "https://modo3.com/thumbs/fit630x300/113668/1592414895/%D8%A2%D8%AB%D8%A7%D8%B1_%D8%A7%D9%84%D8%B9%D9%86%D9%81_%D8%B6%D8%AF_%D8%A7%D9%84%D9%85%D8%B1%D8%A3%D8%A9.jpg",
                      title: "العنف",
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SingleInfo(
                                appBarTitle: "العنف", type: "3"))),
                    child: const ItemWidget2(
                      image:
                          "https://modo3.com/thumbs/fit630x300/113668/1592414895/%D8%A2%D8%AB%D8%A7%D8%B1_%D8%A7%D9%84%D8%B9%D9%86%D9%81_%D8%B6%D8%AF_%D8%A7%D9%84%D9%85%D8%B1%D8%A3%D8%A9.jpg",
                      title: "العنف",
                    ),
                  )
                ]))));
  }
}

class ItemWidget2 extends StatelessWidget {
  final String image, title;
  const ItemWidget2({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Column(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover))),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("", overflow: TextOverflow.ellipsis, maxLines: 1),
              const SizedBox(height: 16)
            ])
          ])),
    );
  }
}
