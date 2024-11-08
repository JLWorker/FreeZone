import 'package:flutter/material.dart';
import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:free_zone/service/VpnConfigRunnerService.dart';

class ConnectionWidget extends StatelessWidget {

  VpnConfigFile configFile;

  ConnectionWidget({required this.configFile});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Connect with vpn config ${configFile.fileName}?'),
      content: Text('Do you want to connect with this VPN configuration?'),
      actions: [
        TextButton(
          onPressed: () {
            VpnConfigRunnerService.runVpnConfig(configFile);
            Navigator.of(context).pop(); // Close the dialog

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('VPN connected from config!')),
            );
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('No'),
        ),
      ],
    );
  }
}