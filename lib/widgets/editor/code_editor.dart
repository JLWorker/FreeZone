import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CodeEditor extends StatefulWidget {

  final String filePath;

  const CodeEditor({Key? key, required this.filePath}) : super(key: key);

  @override
  _CodeEditorWidgetState createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditor> {
  TextEditingController _controller = TextEditingController();
  bool _isLoading = true;

  Future<void> loadFileContent() async {
    try {
        final file = File(widget.filePath);
        final content = await file.readAsString(); // Чтение содержимого файла
        setState(() {
        _controller.text = content;
        _isLoading = false;
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
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Индикатор загрузки
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null, // Многострочное поле
          style: TextStyle(fontFamily: 'monospace', fontSize: 14), // Моноширинный шрифт
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Редактирование файла',
          ),
        ),
      ),
    );
  }

}