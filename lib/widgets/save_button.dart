import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_zone/themes/app-style.dart';

class SaveButton extends StatelessWidget {

  final VoidCallback onPressed;

  SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
            'save',
             style: TextStyle(
               color: AppStyle.colorPalette["base"],
               fontSize: 20
             ),
        ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          AppStyle.colorPalette["white"]
        ),
        minimumSize: MaterialStateProperty.all(Size(200, 50)), // Минимальные размеры кнопки
      ),
    );
  }


}