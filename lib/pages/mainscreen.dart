import 'package:flutter/material.dart';
import 'package:free_zone/pages/editcreen.dart' as edit_page;
import 'package:free_zone/pages/vpnscreen.dart' as vpn_screen;
import 'package:free_zone/widgets/header.dart';
import 'package:free_zone/themes/app-style.dart';
import 'package:free_zone/widgets/footer_image.dart';
import 'package:free_zone/pages/edit_page.dart' as edit_page;

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
    vpn_screen.VpnScreen(),
    edit_page.EditPage(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyle.MainColor,
          title: const Header(),
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: FooterImage('assets/icons/globe-earth.png'), label: ""),
            BottomNavigationBarItem(
                icon: FooterImage('assets/icons/add.png'), label: ""),
            BottomNavigationBarItem(
                icon: FooterImage('assets/icons/edit.png'), label: ""),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppStyle.footer.color,
          currentIndex: _selectedIndex,  // Устанавливаем текущий индекс
          onTap: _onItemTapped,
        )
    );
  }
}