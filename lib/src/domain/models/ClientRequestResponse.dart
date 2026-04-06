import 'dart:convert';
import 'package:localdriver/src/domain/models/DriverCarInfo.dart';

List<ClientRequestResponse> clientRequestResponseFromJson(String str) {
  final List<dynamic> jsonData = json.decode(str);
  return ClientRequestResponse.fromJsonList(jsonData);
}
    

String clientRequestResponseToJson(ClientRequestResponse data) =>
    json.encode(data.toJson());

class ClientRequestResponse {
  int id;
  int idClient;
  String fareOffered;
  String pickupDescription;
  String destinationDescription;
  DateTime updatedAt;
  DateTime? createdAt;
  Position pickupPosition;
  Position destinationPosition;
  double? distance;
  String? timeDifference;
  Client? client;
  Client? driver;
  GoogleDistanceMatrix? googleDistanceMatrix;
  int? idDriverAssigned;
  double? fareAssigned;
  double? clientRating;
  double? driverRating;
  String? status;
  DriverCarInfo? car;
  String? requiredWeight;
  String? weightUnit;
  String? truckType;
  bool? requireHelpers;
  bool? requireCrane;

  ClientRequestResponse({
    required this.id,
    required this.idClient,
    required this.fareOffered,
    required this.pickupDescription,
    required this.destinationDescription,
    required this.updatedAt,
    this.createdAt,
    required this.pickupPosition,
    required this.destinationPosition,
    this.distance,
    this.timeDifference,
    required this.client,
    this.googleDistanceMatrix,
    this.fareAssigned,
    this.idDriverAssigned,
    this.clientRating,
    this.driverRating,
    this.status,
    this.driver,
    this.car,
    this.requiredWeight,
    this.weightUnit,
    this.truckType,
    this.requireHelpers,
    this.requireCrane,
  });

  static List<ClientRequestResponse> fromJsonList(List<dynamic> jsonList) {
    List<ClientRequestResponse> list = [];

    for (var json in jsonList) {
      try {
        list.add(ClientRequestResponse.fromJson(json));
      } catch (e) {
        print('💥 ERROR EN ITEM: $json');
        print('💥 ERROR: $e');
      }
    }

    return list;
  }

  factory ClientRequestResponse.fromJson(Map<String, dynamic> json) {
    try {
      return ClientRequestResponse(
        id: json["id"] is int ? json["id"] : int.tryParse(json["id"].toString()) ?? 0,
        idClient: json["id_client"],
        fareOffered: json["fare_offered"]?.toString() ?? "0",
        pickupDescription: json["pickup_description"] ?? "",
        destinationDescription: json["destination_description"] ?? "",
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"]) ?? DateTime.now()
            : DateTime.now(),
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        pickupPosition: Position(
          lat: (json["pickup_lat"] ?? 0).toDouble(),
          lng: (json["pickup_lng"] ?? 0).toDouble(),
        ),
        destinationPosition: Position(
          lat: (json["destination_lat"] ?? 0).toDouble(),
          lng: (json["destination_lng"] ?? 0).toDouble(),
        ),        
        distance: json["distance"] != null
          ? double.tryParse(json["distance"].toString()) ?? 0
          : 0,

        timeDifference: json["time_difference"]?.toString(),

        client: json["client"] != null
            ? Client.fromJson(json["client"])
            : null,

        driver: json["driver"] != null
            ? Client.fromJson(json["driver"])
            : null,

        idDriverAssigned: json["id_driver_assigned"],

        fareAssigned: json["fare_assigned"] != null
          ? double.tryParse(json["fare_assigned"].toString())
          : null,

        clientRating: json["client_rating"] != null
            ? (json["client_rating"]).toDouble()
            : null,

        driverRating: json["driver_rating"] != null
            ? (json["driver_rating"]).toDouble()
            : null,

        status: json["status"],

        googleDistanceMatrix: json["google_distance_matrix"] != null
            ? GoogleDistanceMatrix.fromJson(json["google_distance_matrix"])
            : null,

        car: json["car"] != null
            ? DriverCarInfo.fromJson(json["car"])
            : null,

        requiredWeight: json['cargo_weight']?.toString(),
        weightUnit: json['cargo_weight_unit'],
        truckType: json['truck_type_required'],

        // 🔥 FIX IMPORTANTE
        requireHelpers: json['helpers_required'] == 1,
        requireCrane: json['requires_crane'] == 1,
      );
    } catch (e) {
      print('❌ ERROR PARSEANDO ClientRequestResponse: $e');
      print('❌ JSON PROBLEMATICO: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "pickup_lat": pickupPosition.lat,
        "pickup_lng": pickupPosition.lng,
        "destination_lat": destinationPosition.lat,
        "destination_lng": destinationPosition.lng,
        "distance": distance,
        "time_difference": timeDifference,
        "client": client!.toJson(),
        "google_distance_matrix": googleDistanceMatrix?.toJson(),
        "id_driver_assigned": idDriverAssigned,
        "fare_assigned": fareAssigned,
        "client_rating": clientRating,
        "driver_rating": driverRating,
        "status": status,
        "driver": driver?.toJson(),
        "car": car?.toJson(),
      };
}

class Client {
  String name;
  dynamic image;
  String phone;
  dynamic lastname;

  Client({
    required this.name,
    required this.image,
    required this.phone,
    required this.lastname,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"] ?? "",
        image: json["image"] ?? "",
        phone: json["phone"]?.toString() ?? "",
        lastname: json["lastname"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "phone": phone,
        "lastname": lastname,
      };
}

class Position {
  double lat;
  double lng;

  Position({required this.lat, required this.lng});

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class GoogleDistanceMatrix {
  Distance distance;
  Distance duration;
  String status;

  GoogleDistanceMatrix({
    required this.distance,
    required this.duration,
    required this.status,
  });

  factory GoogleDistanceMatrix.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return GoogleDistanceMatrix(
        distance: Distance(text: "0 km", value: 0),
        duration: Distance(text: "0 min", value: 0),
        status: "",
      );
    }
    return GoogleDistanceMatrix(
      distance: json["distance"] != null
          ? Distance.fromJson(json["distance"])
          : Distance(text: "0 km", value: 0),
      duration: json["duration"] != null
          ? Distance.fromJson(json["duration"])
          : Distance(text: "0 min", value: 0),
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "distance": distance.toJson(),
        "duration": duration.toJson(),
        "status": status,
      };
}

class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
        text: json["text"] ?? "",
        value: json["value"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "value": value,
      };
}