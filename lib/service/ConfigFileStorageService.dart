import 'dart:io';

import 'package:path_provider/path_provider.dart';
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

  static Future<List<String>> getConfigsFromStorage() async {
    // Получаем папку с конфигами
    Directory freeZoneDir = await getOrCreateConfigDirectory();

    // Получаем список файлов в директории
    List<FileSystemEntity> files = freeZoneDir.listSync();
    List<String> contentsList = [];

    // Читаем содержимое каждого файла
    for (var file in files) {
      if (file is File) {
        String contents = await file.readAsString();
        contentsList.add(contents);
      }
    }

    return contentsList;
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