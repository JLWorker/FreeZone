import 'package:flutter/material.dart';

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

  Future<void> _toggleConnectionWireguard() async {
    await _toggleWireguardVpn();
    setState(() {
      _isConnected = !_isConnected;
    });
  }

  Future<void> _toggleWireguardVpn() async {
    final wireguard = WireGuardFlutter.instance;

    // Инициализируем интерфейс
    await wireguard.initialize(interfaceName: 'wg0');

    const String conf = '''[Interface]
    PrivateKey = eDIQ44DEmrXeGRJTFNpRcoqEmaQ8BTp4uNUobhcwwnI=
    Address = 10.8.0.2/24
    DNS = 1.1.1.1
    
    [Peer]
    PublicKey = akB9R4mC96k1/L/WJhhW9DekqAIMdsz6H67U0wVpkiU=
    PresharedKey = 6V5FL7NgTufJOwwqQmB6G8C4FKqTjbLaTa1WEeANUT4=
    AllowedIPs = 0.0.0.0/0, ::/0
    PersistentKeepalive = 0
    Endpoint = 176.124.201.152:51820
''';

    const String address = '176.124.201.152:51821';

    if (!_isConnected) {
      await wireguard.startVpn(
        serverAddress: address,
        wgQuickConfig: conf,
        providerBundleIdentifier: 'com.freezone.vpn',
      );

    } else {
      await wireguard.stopVpn();
    }
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