class ClientRequest {
  int? id;
  int idClient;
  double fareOffered;
  String pickupDescription;
  String destinationDescription;
  double pickupLat;
  double pickupLng;
  double destinationLat;
  double destinationLng;
  double cargoWeight;
  String cargoWeightUnit;
  String truckTypeRequired;
  String cargoType;
  bool helpersRequired;
  bool requiresCrane;
  bool fragileCargo;
  String? paymentStatus;
  String? status;

  ClientRequest({
    this.id,
    required this.idClient,
    required this.fareOffered,
    required this.pickupDescription,
    required this.destinationDescription,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.cargoWeight,
    required this.cargoWeightUnit,
    required this.truckTypeRequired,
    required this.cargoType,
    required this.helpersRequired,
    required this.requiresCrane,
    required this.fragileCargo,
    this.paymentStatus,
    this.status,
  });

  factory ClientRequest.fromJson(Map<String, dynamic> json) => ClientRequest(
        id: json["id"],
        idClient: json["id_client"],        
        fareOffered: double.parse(json['fare_offered'].toString()),
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        pickupLat: json["pickup_lat"]?.toDouble(),
        pickupLng: json["pickup_lng"]?.toDouble(),
        destinationLat: json["destination_lat"]?.toDouble(),
        destinationLng: json["destination_lng"]?.toDouble(),
        cargoWeight: json["cargo_weight"]?.toDouble(),
        cargoWeightUnit: json["cargo_weight_unit"],
        truckTypeRequired: json["truck_type_required"],
        cargoType: json["cargo_type"],
        helpersRequired: json["helpers_required"] ?? false,
        requiresCrane: json["requires_crane"] ?? false,
        fragileCargo: json["fragile_cargo"] ?? false,
        paymentStatus: json["payment_status"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "pickup_lat": pickupLat,
        "pickup_lng": pickupLng,
        "destination_lat": destinationLat,
        "destination_lng": destinationLng,
        "cargo_weight": cargoWeight,
        "cargo_weight_unit": cargoWeightUnit,
        "truck_type_required": truckTypeRequired,
        "cargo_type": cargoType,
        "helpers_required": helpersRequired,
        "requires_crane": requiresCrane,
        "fragile_cargo": fragileCargo,
      };
}