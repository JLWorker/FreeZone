class VpnConfig {
  String protocolName;
  String config;

  VpnConfig({required this.protocolName, required this.config});

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'protocolName': protocolName,
      'config': config
    };
  }

  // Метод для создания объекта из JSON
  factory VpnConfig.fromJson(Map<String, dynamic> json) {
    return VpnConfig(
        protocolName: json['protocolName'],
        config: json['config']
    );
  }
}