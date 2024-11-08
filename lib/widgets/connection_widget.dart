import 'package:flutter/material.dart';

class ConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Connect with vpn config #1?'),
      content: Text('Do you want to connect with this VPN configuration?'),
      actions: [
        TextButton(
          onPressed: () {
            // Handle "Yes" button press
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            // Handle "No" button press
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('No'),
        ),
      ],
    );
  }
}