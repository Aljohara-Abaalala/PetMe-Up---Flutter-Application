import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:pet_home/StudentHome/StudentDashPage.dart';
import 'package:pet_home/StudentHome/home_page.dart';
import 'package:pet_home/StudentHome/support_page.dart';
import 'package:pet_home/StudentHome/profile_page.dart';

class StudentBottomNav extends StatefulWidget {
  const StudentBottomNav({super.key});

  @override
  State<StudentBottomNav> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<StudentBottomNav> {
  int _selectedIndex = 0;
  List pages = const [
    HomePage(),
    SupportPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 90, right: 90),
          child: BottomNavigationBar(
            elevation: 0,
            iconSize: 35,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconlyBold.category),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.support_agent),
                label: 'Support',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xff3f60a0),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
