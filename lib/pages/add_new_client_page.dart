import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/constants/AppConstants.dart';
import 'package:free_zone/constants/vpn_protocols_constants.dart';
import 'package:free_zone/models/configs/WireguardVpnConfig.dart';
import 'package:free_zone/models/vpn_config.dart';
import 'package:free_zone/service/ConfigFileStorageService.dart';
import 'package:free_zone/themes/app-style.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';
import 'package:free_zone/widgets/ConnectionWidget.dart';

class AddNewClientPage extends StatefulWidget {
  @override
  _AddNewClientPageState createState() => _AddNewClientPageState();
}

class _AddNewClientPageState extends State<AddNewClientPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedItem; // Переменная для хранения выбранного элемента
  final List<String> _vpnProtocols = [
    VpnProtocolsConstants.WIREGUARD_VPN_PROTOCOL_NAME,
    VpnProtocolsConstants.IKEV2_VPN_PROTOCOL_NAME];
  final TextEditingController _nameController = TextEditingController();
  String? _filePath; // Переменная для хранения пути к выбранному файлу

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _configNameController = TextEditingController();
  String? _serverUrl;

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      // Здесь можно сохранить данные или выполнить проверку


      if (_selectedItem != null) {

        String vpnConfig = "";

        if (_selectedItem == VpnProtocolsConstants.WIREGUARD_VPN_PROTOCOL_NAME) {
          await _showFilePath();

          // Вывод данных в консоль (или можно сохранить в базе данных)
          print('Type: $_selectedItem');

          _serverUrl = _urlController.text; // Сохраняем URL в переменной

          final wireguard = WireGuardFlutter.instance;

          // Инициализируем интерфейс
          await wireguard.initialize(interfaceName: 'wg0');

          String fileContents = await readFile(_filePath!);

          VpnConfig vpnConfigObj = VpnConfig(protocolName: VpnProtocolsConstants.WIREGUARD_VPN_PROTOCOL_NAME,
              config: jsonEncode(WireguardVpnConfig(serverAddress: _serverUrl!, configContent: fileContents, appName: AppConstants.APP_DOMAIN_NAME)));

          vpnConfig = jsonEncode(vpnConfigObj);

        } else if (_selectedItem == VpnProtocolsConstants.IKEV2_VPN_PROTOCOL_NAME) {
          throw UnimplementedError();
        }

        String? configName = _configNameController.text;

        if (configName != null && !configName.isEmpty) {
          ConfigFileStorageService.saveConfigToStorage(vpnConfig, configName!);
        }


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
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add new config',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'type',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child:
                  DropdownButton<String>(
                    hint: Text('Select vpn protocol'),
                    value: _selectedItem,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue;
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
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'path:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Путь к файлу',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.folder),
                    onPressed: _pickFile,
                  ),
                ),
                controller: TextEditingController(text: _filePath),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'server address:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'https://example.com',
                    hintStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Config name:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: _configNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'config name',
                    hintStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Create configuration file'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}