import 'package:flutter/material.dart';
import 'package:free_zone/widgets/config_editor.dart' as config_editor;
import 'package:free_zone/widgets/footer_image.dart';

import '../themes/app-style.dart';

class Mainscreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<Mainscreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('My App'),
    ),
    // body: _screens[_selectedIndex],
    bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: FooterImage('assets/icons/globe-earth.png'),
      label: ""
    ),
    BottomNavigationBarItem(
      icon: FooterImage('assets/icons/add.png'),
      label: ""
    ),
    BottomNavigationBarItem(
      icon: FooterImage('assets/icons/edit.png'),
      label: ""
    ),
    ],
      showSelectedLabels: false,
      showUnselectedLabels: false,
    backgroundColor: AppStyle.footer.color,
    ),
    );
  }
}