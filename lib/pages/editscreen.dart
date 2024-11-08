import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/widgets/editor/code_editor.dart';
import 'package:free_zone/widgets/save_button.dart';

class EditPage extends StatefulWidget {

  final String filePath;

  const EditPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CodeEditorWidgetState> _editorKey = GlobalKey();
    final SaveButton saveButton = SaveButton(
      onPressed: () {
        if (_editorKey.currentState != null) {
          _editorKey.currentState!.saveFile();
        }
      }, colorSwitch: 'none'
    );

    final List<Widget> _widgetsOnEditPage = [
      CodeEditor(filePath: widget.filePath, key: _editorKey),
      saveButton
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height*0.8,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Expanded(
                  child: _widgetsOnEditPage[0],
                ),
                SizedBox(
                  child: _widgetsOnEditPage[1],
                  width: 200,
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}