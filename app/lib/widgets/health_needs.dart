// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:ecommerce/pages/Info/Info.dart';
import 'package:flutter/material.dart';

class HealthNeeds extends StatelessWidget {
  const HealthNeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(name: "الحجوزات", icon: 'assets/appointment.png'),
      CustomIcon(name: "العيادات", icon: 'assets/hospital.png'),
      CustomIcon(name: "ثقف نفسك", icon: 'assets/virus.png'),
    ];

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(customIcons.length, (i) {
          return Column(children: [
            InkWell(
                onTap: () {
                  if (i == 2) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const InfoScreen()));
                  }
                },
                borderRadius: BorderRadius.circular(90),
                child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer
                            .withOpacity(0.4),
                        shape: BoxShape.circle),
                    child: Image.asset(customIcons[i].icon))),
            const SizedBox(height: 6),
            Text(customIcons[i].name)
          ]);
        }));
  }
}

class CustomIcon {
  final String name;
  final String icon;

  CustomIcon({required this.name, required this.icon});
}
