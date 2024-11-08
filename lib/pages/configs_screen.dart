import 'package:flutter/material.dart';
import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:free_zone/service/ConfigFileStorageService.dart';
import 'package:free_zone/widgets/ConnectionWidget.dart';

class ConfigsScreen extends StatefulWidget {
  @override
  _ConfigsScreenState createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
  List<String> configNames = [];
  List<VpnConfigFile> configFiles = [];

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
    configFiles = await ConfigFileStorageService.getConfigsFromStorage();
    return (configFiles).map((file) {
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
        padding: EdgeInsets.all(16.0),
        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: configFiles.map((file) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConnectionWidget(configFile: file);
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor:  AppStyle.colorPalette["white"]
              ),
              child: Text(label, style: TextStyle(color: AppStyle.colorPalette["base"])),
            );
          }).toList(),
        ),
      ),
    );
  }
}