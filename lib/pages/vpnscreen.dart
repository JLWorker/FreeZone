import 'package:flutter/material.dart';
import 'package:ikev_flutter/flutter_vpn.dart';
import 'package:ikev_flutter/state.dart';

class VpnScreen extends StatefulWidget {
  @override
  _VpnScreenState createState() => _VpnScreenState();
}

class _VpnScreenState extends State<VpnScreen> {
  var state = FlutterVpnState.disconnected;
  CharonErrorState? charonState = CharonErrorState.NO_ERROR;
  void _toggleConnection() async {
    print("state ");
    print(state);
    if (state == FlutterVpnState.disconnected) {
      await FlutterVpn.connectIkev2EAP(
          server: 'vpnfr01.fornex.org',
          username: '4357480@bk_64076',
          password: 'kLbiouni3Na5I4yd'
      );
    }
    if (state != FlutterVpnState.connected) {
      await FlutterVpn.disconnect();
    }
  }

  @override
  void initState() {
    FlutterVpn.prepare();
    FlutterVpn.onStateChanged.listen((s) => setState(() => state = s));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            state == FlutterVpnState.connected ? Icons.vpn_lock : Icons.lock_open,
            size: 100,
            color: state != FlutterVpnState.connected ? Colors.green : Colors.red,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _toggleConnection,
            child: Text(state == FlutterVpnState.connected ? 'Отключиться от VPN' : 'Подключиться к VPN'),
          ),
        ],
      ),
    );
  }
}