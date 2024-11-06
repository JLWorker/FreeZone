import 'package:flutter/material.dart';

class VpnScreen extends StatefulWidget {
  @override
  _VpnScreenState createState() => _VpnScreenState();
}

class _VpnScreenState extends State<VpnScreen> {
  bool _isConnected = false;

  void _toggleConnection() {
    setState(() {
      _isConnected = !_isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isConnected ? Icons.vpn_lock : Icons.lock_open,
            size: 100,
            color: _isConnected ? Colors.green : Colors.red,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleConnection,
            child: Text(_isConnected ? 'Отключиться от VPN' : 'Подключиться к VPN'),
          ),
        ],
      ),
    );
  }
}