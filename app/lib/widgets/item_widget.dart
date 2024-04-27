import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  String image, title, otherData, doctorName;
  bool isHaveDoctor;
  ItemWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.otherData,
      this.isHaveDoctor = false,
      this.doctorName = ''});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(children: [
          Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover))),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(otherData, overflow: TextOverflow.ellipsis, maxLines: 1),
            const SizedBox(height: 16),
            isHaveDoctor
                ? Text(doctorName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold))
                : const SizedBox(),
          ])
        ]));
  }
}
