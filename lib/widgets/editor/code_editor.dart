import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/themes/app-style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CodeEditor extends StatefulWidget {
  final String filePath; // Путь к файлу, который нужно открыть

  const CodeEditor({Key? key, required this.filePath}) : super(key: key);

  @override
  CodeEditorWidgetState createState() => CodeEditorWidgetState(filePath);
}


class CodeEditorWidgetState extends State<CodeEditor> {

  final String filePath;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    loadFileContent();
    requestPermissions();
  }


  Future<void> requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      print("Разрешение на доступ к хранилищу предоставлено");
    } else if (status.isDenied) {
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> saveFile() async {
    try {
      final file = File(filePath);
      String newContent = _controller.text;
      await file.writeAsString(newContent);
      print('File saved successfully at: $filePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  }

  late TextEditingController _controller; // Контроллер для TextField
  bool _isLoading = true;

  CodeEditorWidgetState(this.filePath);



  // Загрузить содержимое файла
  Future<void> loadFileContent() async {
    try {

      final file = File(widget.filePath);
      final content = await file.readAsString(); // Чтение содержимого файла
      setState(() {
        _controller.text = content; // Устанавливаем текст в контроллер
        _isLoading = false; // Прекращаем индикатор загрузки
      });
    } catch (e) {
      setState(() {
        _controller.text = 'Ошибка при загрузке файла: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double textFieldHeight = screenHeight * 0.6;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Индикатор загрузки
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: textFieldHeight,
          child: TextField(
            controller: _controller,  // Контроллер для управления текстом
            maxLines: null,  // Многострочное поле
            style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: AppStyle.colorPalette["editor_text_color"]
            ),

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true, // Включаем заполнение фона
              fillColor: AppStyle.colorPalette["editor_background"], // Цвет фона (светло-серый)
            ),
          ),
        ),
      ),
    );
  }
}