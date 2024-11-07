import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/widgets/editor/code_editor.dart';
import 'package:free_zone/widgets/save_button.dart';

class EditPage extends StatefulWidget {

  final String filePath; // Путь к файлу

  const EditPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState(filePath);
}

class _EditPageState extends State<EditPage> {

  String _currentFile;

  _EditPageState(this._currentFile);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CodeEditorWidgetState> _editorKey = GlobalKey();
    // Определяем кнопку с вызовом метода saveFile только после инициализации
    final SaveButton saveButton = SaveButton(
      onPressed: () {
        // Проверяем, и если состояние доступно, вызываем saveFile
        if (_editorKey.currentState != null) {
          _editorKey.currentState!.saveFile();
        }
      }
    );

    final List<Widget> _widgetsOnEditPage = [
      CodeEditor(filePath: _currentFile, key: _editorKey),
      saveButton
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _widgetsOnEditPage[0]),
          Expanded(child: _widgetsOnEditPage[1]),
        ],
      ),
    );
  }

}