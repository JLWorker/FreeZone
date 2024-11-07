class WireguardVpnConfig {
  String serverAddress;
  String configContent;
  String appName;

  WireguardVpnConfig({
    required this.serverAddress,
    required this.configContent,
    required this.appName
  });

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'serverAddress': serverAddress,
      'configContent': configContent,
      'appName': appName
    };
  }

  // Метод для создания объекта из JSON
  factory WireguardVpnConfig.fromJson(Map<String, dynamic> json) {
    return WireguardVpnConfig(
      serverAddress: json['serverAddress'],
      configContent: json['configContent'],
      appName: json['appName']
    );
  }
}