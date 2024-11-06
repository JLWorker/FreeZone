import 'package:flutter/material.dart';

class ConfigEditorScreen extends StatefulWidget {
  @override
  _ConfigEditorScreenState createState() => _ConfigEditorScreenState();
}

class _ConfigEditorScreenState extends State<ConfigEditorScreen> {
  final TextEditingController _configController = TextEditingController();

  void _setConfig() {
    // Логика для сохранения конфигурации (здесь можно добавить сохранение в локальное хранилище или отправку на сервер)
    print("Config set: ${_configController.text}");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Конфигурация установлена")));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _configController,
            decoration: const InputDecoration(
              labelText: 'Введите конфигурацию',
              border: OutlineInputBorder(),
            ),
            maxLines: 6,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _setConfig,
            child: Text('Установить конфигурацию'),
          ),
        ],
      ),
    );
  }
}