import 'dart:convert';

import 'package:free_zone/constants/vpn_protocols_constants.dart';
import 'package:free_zone/models/VpnConfigFile.dart';
import 'package:free_zone/models/configs/WireguardVpnConfig.dart';
import 'package:free_zone/models/vpn_config.dart';

class VpnConfigFileMapper {

  static WireguardVpnConfig mapToWireguardVpnConfigFromVpnConfigFile(VpnConfigFile vpnConfigFile) {
    VpnConfig vpnConfig = VpnConfig.fromJson(jsonDecode(vpnConfigFile.content));
    if (vpnConfig.protocolName != VpnProtocolsConstants.WIREGUARD_VPN_PROTOCOL_NAME) {
      throw UnimplementedError();
    } else {
      return WireguardVpnConfig.fromJson(jsonDecode(vpnConfig.config));
    }
  }

}