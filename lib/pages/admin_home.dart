
import 'package:curriculum_corner/pages/admin_add_year.dart';
import 'package:curriculum_corner/pages/admin_home2.dart';
import 'package:flutter/material.dart';
class admin_home extends StatefulWidget {
  const admin_home({super.key});

  @override
  State<admin_home> createState() => _admin_homeState();
}

class _admin_homeState extends State<admin_home> {
  int _selectedIndex = 0;

  // Define a list of pages to be displayed in the bottom navigation
  final List<Widget> _pages = [
    admin_home2(),
    admin_add_year()
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
