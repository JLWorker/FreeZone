import 'package:flutter/material.dart';

class StatusBar extends StatefulWidget {
  final String status;

  const StatusBar({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('status: ' + this.status),
        ],
      ),
    );
  }
}