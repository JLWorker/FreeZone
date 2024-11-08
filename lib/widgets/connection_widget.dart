import 'package:flutter/material.dart';
import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:free_zone/service/VpnConfigRunnerService.dart';

class ConnectionWidget extends StatelessWidget {

  final Function(String) onFilePathChanged;

  VpnConfigFile configFile;

  ConnectionWidget({required this.configFile, required this.onFilePathChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Connect with vpn config ${configFile.fileName.substring(0, configFile.fileName.length - 4)}?'),
      content: Text('Do you want to connect with this VPN configuration?'),
      actions: [
        TextButton(
          onPressed: () {
            VpnConfigRunnerService.runVpnConfig(configFile);
            Navigator.of(context).pop();
            String newPath = "/storage/emulated/0/Download/freezone/";
            onFilePathChanged(newPath+configFile.fileName);
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