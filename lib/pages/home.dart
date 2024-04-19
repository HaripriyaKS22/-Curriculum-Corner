

import 'package:curriculum_corner/pages/home2.dart';

import 'package:curriculum_corner/pages/user_profile.dart';



import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _selectedIndex = 0;

  // Define a list of pages to be displayed in the bottom navigation
  final List<Widget> _pages = [
   home2(),
  user_profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 137, 1, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
