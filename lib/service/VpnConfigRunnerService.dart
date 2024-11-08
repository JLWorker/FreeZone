import 'package:free_zone/mapper/VpnConfigFileMapper.dart';
import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:free_zone/models/configs/WireguardVpnConfig.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';

class VpnConfigRunnerService {

  static Future<void> runVpnConfig(VpnConfigFile vpnConfigFile) async {

    WireguardVpnConfig wireguardVpnConfig = VpnConfigFileMapper.mapToWireguardVpnConfigFromVpnConfigFile(vpnConfigFile);

    final wireguard = WireGuardFlutter.instance;

    // Инициализируем интерфейс
    await wireguard.initialize(interfaceName: 'wg0');

    await wireguard.startVpn(
      serverAddress: wireguardVpnConfig.serverAddress,
      wgQuickConfig: wireguardVpnConfig.configContent,
      providerBundleIdentifier: wireguardVpnConfig.appName,
    );

  }

}