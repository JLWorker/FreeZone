import 'package:flutter/material.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

class VpnScreen extends StatefulWidget {
  @override
  _VpnScreenState createState() => _VpnScreenState();
}

class _VpnScreenState extends State<VpnScreen> {
  bool _isConnected = false;

  Future<void> _toggleConnection() async {
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