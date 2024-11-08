import 'dart:io';
import 'package:free_zone/constants/AppConstants.dart';
import 'package:path/path.dart' as path;

import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:permission_handler/permission_handler.dart';

class ConfigFileStorageService {

  static Future<void> saveConfigToStorage(String configContent, String configName) async {

    await requestStoragePermission();

    Directory freeZoneDir = await getOrCreateConfigDirectory();
    File file = File('${freeZoneDir.path}/' + configName + '.txt');
    await file.writeAsString(configContent, mode: FileMode.writeOnly);
  }

  static Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  static Future<List<VpnConfigFile>> getConfigsFromStorage() async {
    Directory freeZoneDir = await getOrCreateConfigDirectory();

    List<FileSystemEntity> files = freeZoneDir.listSync();
    List<String> contentsList = [];
    List<VpnConfigFile> configFiles = [];

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

    Directory? appDirectory = await getAppDirectory();

    if (appDirectory == null) {
      throw UnimplementedError();
    } else {
      if (!appDirectory!.existsSync()) {
        await appDirectory.create(recursive: true);
      }

      return appDirectory!;
    }
  }

  static Future<Directory?> getAppDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download' + '/${AppConstants.APP_STORAGE_DIRECTORY_NAME}');
    } else {
      return null; // Для других платформ
    }
  }

}