class DriverCarInfo {
  int? idDriver;

  String brand;
  String model;
  int? year;

  String plate;
  String color;

  String? maxWeight;
  String? weightUnit;
  String? truckType;
  double? maxVolume;

  bool hasHelpers;
  bool hasCrane;

  DriverCarInfo({
    this.idDriver,
    required this.brand,
    required this.model,
    this.year,
    required this.plate,
    required this.color,
    this.maxWeight,
    this.weightUnit,
    this.truckType,
    this.maxVolume,
    this.hasHelpers = false,
    this.hasCrane = false,
  });

  factory DriverCarInfo.fromJson(Map<String, dynamic> json) => DriverCarInfo(
        idDriver: json["id_driver"],
        brand: json["brand"] ?? '',
        model: json["model"] ?? '', // ✅ agregado
        year: json["year"] != null
            ? int.tryParse(json["year"].toString())
            : null, // ✅ agregado
        plate: json["plate"] ?? '',
        color: json["color"] ?? '',
        maxWeight: json["max_weight"]?.toString(),
        weightUnit: json["weight_unit"]?.toString(),
        truckType: json["truck_type"]?.toString(),
        maxVolume: json["max_volume"] != null
            ? double.tryParse(json["max_volume"].toString())
            : null,
        hasHelpers: json["has_helpers"] ?? false,
        hasCrane: json["has_crane"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id_driver": idDriver,
        "brand": brand,
        "model": model, // ✅ agregado
        "year": year,   // ✅ agregado
        "plate": plate,
        "color": color,
        "max_weight": maxWeight,
        "weight_unit": weightUnit,
        "truck_type": truckType,
        "max_volume": maxVolume,
        "has_helpers": hasHelpers,
        "has_crane": hasCrane,
      };
}