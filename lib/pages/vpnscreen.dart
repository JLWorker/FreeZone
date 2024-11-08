import 'package:flutter/material.dart';
import 'package:flutter_vpn/flutter_vpn.dart';
import 'package:flutter_vpn/state.dart';
import 'package:free_zone/themes/app-style.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';
import 'package:free_zone/widgets/status_bar.dart';
import 'package:free_zone/pages/configs_screen.dart' as config_screen;

class VpnScreen extends StatefulWidget {

  final Function(String) onFilePathChanged;

  VpnScreen({required this.onFilePathChanged});

  @override
  _VpnScreenState createState() => _VpnScreenState();
}

class _VpnScreenState extends State<VpnScreen> {
  bool _isConnected = false;
  var state = FlutterVpnState.disconnected;
  CharonErrorState? charonState = CharonErrorState.NO_ERROR;

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
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: StatusBar(status: state.toString()),
            color: Colors.grey,
          ),
          Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: _toggleConnectionWireguard,
                  child: !_isConnected
                      ? Image.asset(
                          'assets/icons/unlock.png',
                          scale: 4,
                        )
                      : Image.asset('assets/icons/lock.png', scale: 4)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => config_screen.ConfigsScreen(onFilePathChanged: widget.onFilePathChanged,)),
                  );
                },
                child: Text("Выбрать конфигурацию", style: TextStyle(color: AppStyle.colorPalette["white"])),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyle.colorPalette["base"]
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      )),
    );
  }
}
