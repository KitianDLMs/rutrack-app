import 'dart:convert';
import 'package:localdriver/src/domain/models/DriverCarInfo.dart';

ClientRequestResponse clientRequestResponseFromJson(String str) => ClientRequestResponse.fromJson(json.decode(str));
String clientRequestResponseToJson(ClientRequestResponse data) => json.encode(data.toJson());

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
  Client client;
  Client? driver;
  GoogleDistanceMatrix? googleDistanceMatrix;
  int? idDriverAssigned;
  double? fareAssigned;
  DriverCarInfo? car;

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
    this.driver,
    this.car,
  });

  static List<ClientRequestResponse> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ClientRequestResponse.fromJson(json)).toList();
  }

  factory ClientRequestResponse.fromJson(Map<String, dynamic> json) => ClientRequestResponse(
        id: json["id"],
        idClient: json["id_client"],
        fareOffered: json["fare_offered"]?.toString() ?? "0",
        pickupDescription: json["pickup_description"],
        destinationDescription: json["destination_description"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        pickupPosition: Position(
          lat: json["pickup_lat"]?.toDouble() ?? 0,
          lng: json["pickup_lng"]?.toDouble() ?? 0,
        ),
        destinationPosition: Position(
          lat: json["destination_lat"]?.toDouble() ?? 0,
          lng: json["destination_lng"]?.toDouble() ?? 0,
        ),
        distance: json["distance"]?.toDouble(),
        timeDifference: json["time_difference"],
        client: Client.fromJson(json["client"]),
        driver: json["driver"] != null ? Client.fromJson(json["driver"]) : null,
        idDriverAssigned: json["id_driver_assigned"],
        fareAssigned: json["fare_assigned"]?.toDouble(),
        googleDistanceMatrix: json["google_distance_matrix"] != null
            ? GoogleDistanceMatrix.fromJson(json["google_distance_matrix"])
            : null,
        car: json["car"] != null ? DriverCarInfo.fromJson(json["car"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "fare_offered": fareOffered,
        "pickup_description": pickupDescription,
        "destination_description": destinationDescription,
        "updated_at": updatedAt.toIso8601String(),
        "pickup_lat": pickupPosition.lat,
        "pickup_lng": pickupPosition.lng,
        "destination_lat": destinationPosition.lat,
        "destination_lng": destinationPosition.lng,
        "distance": distance,
        "time_difference": timeDifference,
        "client": client.toJson(),
        "google_distance_matrix": googleDistanceMatrix?.toJson(),
        "id_driver_assigned": idDriverAssigned,
        "fare_assigned": fareAssigned,
        "driver": driver?.toJson(),
        "car": car?.toJson(),
      };
}

class Client {
  String name;
  dynamic image;
  String phone;
  String lastname;

  Client({
    required this.name,
    required this.image,
    required this.phone,
    required this.lastname,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"] ?? "",
        image: json["image"],
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
      // valores por defecto
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