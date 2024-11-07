import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/themes/app-style.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

class AddNewClientPage extends StatefulWidget {
  @override
  _AddNewClientPageState createState() => _AddNewClientPageState();
}

class _AddNewClientPageState extends State<AddNewClientPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedItem; // Переменная для хранения выбранного элемента
  final List<String> _vpnProtocols = ['WireGuard', 'IKEV2'];
  final TextEditingController _nameController = TextEditingController();
  String? _filePath; // Переменная для хранения пути к выбранному файлу

  final TextEditingController _urlController = TextEditingController();
  String? _serverUrl;

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      // Здесь можно сохранить данные или выполнить проверку


      if (_selectedItem != null) {

        await _showFilePath();

        // Вывод данных в консоль (или можно сохранить в базе данных)
        print('Type: $_selectedItem');

        _serverUrl = _urlController.text; // Сохраняем URL в переменной

        final wireguard = WireGuardFlutter.instance;

        // Инициализируем интерфейс
        await wireguard.initialize(interfaceName: 'wg0');

        String fileContents = await readFile(_filePath!);

        await wireguard.startVpn(
          serverAddress: _serverUrl!,
          wgQuickConfig: fileContents,
          providerBundleIdentifier: 'com.freezone.vpn',
        );

        // Сообщение об успешном сохранении
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('VPN is ON!')),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Пожалуйста, выберите элемент')),
        );
      }
    }
  }

  Future<void> _pickFile() async {
    // Открытие диалогового окна выбора файла
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path; // Сохранение пути к выбранному файлу
      });
    } else {
      // Пользователь отменил выбор файла
      setState(() {
        _filePath = null;
      });
    }
  }

  Future<String> readFile(String filePath) async {
    try {
      final file = File(filePath);
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print("Ошибка при чтении файла: $e");
      return '';
    }
  }

  Future<void> _showFilePath() async {
    if (_filePath != null) {
      String fileContents = await readFile(_filePath!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Содержимое файла: $fileContents')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Файл не выбран')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.MainColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                child: Text(
                  'Add new client',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0), // Отступ между лейблом и текстовым полем
              Align(
                alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                child: Text(
                  'type',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0), // Отступ между лейблом и текстовым полем
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Цвет фона
                  borderRadius: BorderRadius.circular(8.0), // Скругление углов
                ),
                child:
                  DropdownButton<String>(
                    hint: Text('Select vpn protocol'),
                    value: _selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue; // Обновляем выбранный элемент
                      });
                    },
                    items: _vpnProtocols.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
              ),
              SizedBox(height: 8.0), // Отступ между лейблом и текстовым полем
              Align(
                alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                child: Text(
                  'path:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0), // Отступ между лейблом и текстовым полем
              TextField(
                readOnly: true, // Поле только для чтения
                decoration: InputDecoration(
                  labelText: 'Путь к файлу',
                  border: OutlineInputBorder(),
                  filled: true, // Включаем заливку
                  fillColor: Colors.white, // Белый фон
                  suffixIcon: IconButton(
                    icon: Icon(Icons.folder),
                    onPressed: _pickFile, // Вызов метода выбора файла
                  ),
                ),
                controller: TextEditingController(text: _filePath), // Отображение пути
              ),
              Align(
                alignment: Alignment.centerLeft, // Выровнять текст по левому краю
                child: Text(
                  'server address:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0), // Отступ между лейблом и текстовым полем
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Белый фон
                  border: Border.all(color: Colors.black), // Черная рамка
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    border: InputBorder.none, // Убираем стандартную рамку
                    hintText: 'https://example.com',
                    hintStyle: TextStyle(color: Colors.black), // Цвет подсказки
                    contentPadding: EdgeInsets.all(10), // Отступы внутри текстового поля
                  ),
                  style: TextStyle(color: Colors.black), // Черный текст
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Execute configuration file'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}