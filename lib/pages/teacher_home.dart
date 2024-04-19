
import 'package:curriculum_corner/pages/teacher_home2.dart';
import 'package:curriculum_corner/pages/teacher_profile.dart';
import 'package:flutter/material.dart';
class teacher_home extends StatefulWidget {
  const teacher_home({super.key});

  @override
  State<teacher_home> createState() => _teacher_homeState();
}

class _teacher_homeState extends State<teacher_home> {
  int _selectedIndex = 0;

  // Define a list of pages to be displayed in the bottom navigation
  final List<Widget> _pages = [
    teacher_home2(),
    teacher_profile()
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
