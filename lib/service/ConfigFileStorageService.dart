import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:permission_handler/permission_handler.dart';

class ConfigFileStorageService {

  static Future<void> saveConfigToStorage(String configContent, String configName) async {

    await requestStoragePermission();

    // Получаем папку freeZone
    Directory freeZoneDir = await getOrCreateConfigDirectory();
    // Указываем путь к файлу
    File file = File('${freeZoneDir.path}/' + configName + '.txt');
    // Записываем содержимое в файл
    await file.writeAsString(configContent, mode: FileMode.writeOnly);
  }

  static Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  static Future<List<VpnConfigFile>> getConfigsFromStorage() async {
    // Получаем папку с конфигами
    Directory freeZoneDir = await getOrCreateConfigDirectory();

    // Получаем список файлов в директории
    List<FileSystemEntity> files = freeZoneDir.listSync();
    List<String> contentsList = [];
    List<VpnConfigFile> configFiles = [];

    // Читаем содержимое каждого файла
    for (var file in files) {
      String fileName = path.basename(file.path);
      if (file is File) {
        String contents = await file.readAsString();
        contentsList.add(contents);
        configFiles.add(VpnConfigFile(fileName: fileName, content: contents));
      }
    }

    return configFiles;
  }

  static Future<Directory> getOrCreateConfigDirectory() async {
    /*Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory freeZoneDir = Directory('${appDocDir.path}/${AppConstants.APP_STORAGE_DIRECTORY_NAME}');

    if (!await freeZoneDir.exists()) {
      await freeZoneDir.create();
    }

    return freeZoneDir;
    
     */
    
    return Directory('/storage/emulated/0/Download');
  }

  static Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    } else {
      return null; // Для других платформ
    }
  }

}