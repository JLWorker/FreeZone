import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/themes/app-style.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String colorSwitch;

  SaveButton({super.key, required this.onPressed, required this.colorSwitch});

  @override
  Widget build(BuildContext context) {
    bool switchColors = colorSwitch.toLowerCase() == 'switch';

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        'save',
        style: TextStyle(
          color: switchColors ? AppStyle.colorPalette["base"] : AppStyle.colorPalette["white"], // Меняем местами
          fontSize: 20,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: switchColors ? AppStyle.colorPalette["white"] : AppStyle.colorPalette["base"], // Меняем местами
      ),
    );
  }
}