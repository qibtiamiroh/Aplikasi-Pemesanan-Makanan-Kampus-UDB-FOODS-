class AppSettings {
  final String id;
  final String operationalHours;
  final String deliveryZone;
  final double deliveryFee;

  AppSettings({required this.id, required this.operationalHours, required this.deliveryZone, required this.deliveryFee});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      id: json['id'],
      operationalHours: json['operationalHours'],
      deliveryZone: json['deliveryZone'],
      deliveryFee: json['deliveryFee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operationalHours': operationalHours,
      'deliveryZone': deliveryZone,
      'deliveryFee': deliveryFee,
    };
  }
}
