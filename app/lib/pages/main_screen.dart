import 'dart:developer';

import 'package:ecommerce/pages/Account/account.dart';
import 'package:ecommerce/pages/Appointements/appointements.dart';
import 'package:ecommerce/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List screens = [
    const HomePage(),
    const AppointementsScreen(),
    const AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            body: screens[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.home_outline),
                      activeIcon: Icon(Ionicons.home),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.book_outline),
                      activeIcon: Icon(Ionicons.book),
                      label: "Appointements"),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Ionicons.chatbubble_ellipses_outline),
                  //     label: "Chat",
                  //     activeIcon: Icon(Ionicons.chatbubble_ellipses)),
                  BottomNavigationBarItem(
                      icon: Icon(Ionicons.person_outline),
                      activeIcon: Icon(Ionicons.person),
                      label: "Account")
                ])));
  }
}