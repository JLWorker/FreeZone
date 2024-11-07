import 'package:flutter/material.dart';
import 'package:free_zone/widgets/config_editor.dart' as config_editor;
import 'package:free_zone/pages/vpnscreen.dart' as vpnscreen;
import 'package:free_zone/widgets/header.dart';
import 'package:free_zone/themes/app-style.dart';

class main_screen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<main_screen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    vpnscreen.VpnScreen(),
    config_editor.ConfigEditorScreen(),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.vpn_lock),
            label: 'VPN',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}