import 'package:flutter/material.dart';
import 'package:free_zone/service/ConfigFileStorageService.dart';

class ConfigsScreen extends StatefulWidget {
  @override
  _ConfigsScreenState createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
  List<String> configNames = [];

  @override
  void initState() {
    super.initState();
    _loadConfigNames();
  }

  Future<void> _loadConfigNames() async {
    List<String> names = await getConfigs();
    setState(() {
      configNames = names;
    });
  }

  Future<List<String>> getConfigs() async {
    return (await ConfigFileStorageService.getConfigsFromStorage()).map((file) {
      return file.fileName;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configs'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0), // Добавляем отступы
        child: Column(
          children: configNames.map((label) {
            return ElevatedButton(
              onPressed: () {
                // Обработка нажатия на кнопку
                print('Нажата кнопка: $label');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Белый фон кнопки
                foregroundColor: Colors.red, // Красный текст кнопки
              ),
              child: Text(label),
            );
          }).toList(),
        ),
      ),
    );
  }
}