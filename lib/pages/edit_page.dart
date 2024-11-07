import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/widgets/editor/code_editor.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  List<Widget> _widgetsOnEditPage = [CodeEditor(filePath: '')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: _widgetsOnEditPage
      ),
    );
  }
}