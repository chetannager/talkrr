import 'package:flutter/material.dart';
import 'package:talkrr/ui/pages/account/account.dart';
import 'package:talkrr/ui/pages/recents/recents.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int currentIndex = 0;
  List pages = [
    const Recents(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        iconSize: 30.0,
        selectedItemColor: const Color.fromRGBO(0, 194, 255, 1),
        unselectedItemColor: const Color.fromRGBO(96, 99, 103, 1),
        selectedLabelStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: const Color.fromRGBO(33, 36, 42, 1),
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.video_call),
          //   label: "Meeting",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          )
        ],
      ),
    );
  }
}
