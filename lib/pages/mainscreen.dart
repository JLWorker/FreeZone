import 'package:flutter/material.dart';
import 'package:free_zone/pages/configs_screen.dart';
import 'package:free_zone/pages/editscreen.dart';
import 'package:free_zone/pages/vpnscreen.dart' as vpn_screen;
import 'package:free_zone/widgets/header.dart';
import 'package:free_zone/themes/app-style.dart';
import 'package:free_zone/widgets/footer_image.dart';
import 'package:free_zone/pages/editscreen.dart' as edit_page;
import 'package:free_zone/pages/add_new_client_page.dart' as add_new_client_page;
import 'package:free_zone/widgets/connection_widget.dart' as connection_widget;
import 'package:free_zone/pages/configs_screen.dart' as config_screen;


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

  @override
  Widget build(BuildContext context) {

    String _current_filePath = "/storage/emulated/0/Download/freezone/PC.conf";

    void _updateFilePath(String newPath) {
      setState(() {
        _current_filePath = newPath;
      });
    }

    final List<Widget> _screens = [
      vpn_screen.VpnScreen(onFilePathChanged: _updateFilePath),
      add_new_client_page.AddNewClientPage(),
      edit_page.EditPage(filePath: _current_filePath),
      config_screen.ConfigsScreen(onFilePathChanged: _updateFilePath)
    ];

    return Scaffold(

        appBar: AppBar(
          backgroundColor: AppStyle.colorPalette["base"],
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
          backgroundColor: AppStyle.colorPalette["light_gray"],
          currentIndex: _selectedIndex,  // Устанавливаем текущий индекс
          onTap: _onItemTapped,
        )
    );
  }
}
