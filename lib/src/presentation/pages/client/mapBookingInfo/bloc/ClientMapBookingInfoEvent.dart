import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localdriver/src/presentation/utils/BlocFormItem.dart';

abstract class ClientMapBookingInfoEvent {}

// INIT
class ClientMapBookingInfoInitEvent extends ClientMapBookingInfoEvent {
  final LatLng pickUpLatLng;
  final LatLng destinationLatLng;
  final String pickUpDescription;
  final String destinationDescription;

  ClientMapBookingInfoInitEvent({
    required this.pickUpLatLng,
    required this.destinationLatLng,
    required this.pickUpDescription,
    required this.destinationDescription,
  });
}

// TARIFA
class FareOfferedChanged extends ClientMapBookingInfoEvent {
  final BlocFormItem fareOffered;

  FareOfferedChanged({
    required this.fareOffered,
  });
}

// PESO CARGA
class CargoWeightChanged extends ClientMapBookingInfoEvent {
  final BlocFormItem cargoWeight;

  CargoWeightChanged({
    required this.cargoWeight,
  });
}

// UNIDAD PESO
class CargoWeightUnitChanged extends ClientMapBookingInfoEvent {
  final String unit;

  CargoWeightUnitChanged({
    required this.unit,
  });
}

// TIPO CAMIÓN
class TruckTypeChanged extends ClientMapBookingInfoEvent {
  final String type;

  TruckTypeChanged({
    required this.type,
  });
}

// TIPO DE CARGA
class CargoTypeChanged extends ClientMapBookingInfoEvent {
  final String type;

  CargoTypeChanged({
    required this.type,
  });
}

// AYUDANTES
class HelpersRequiredChanged extends ClientMapBookingInfoEvent {
  final bool value;

  HelpersRequiredChanged({
    required this.value,
  });
}

// GRÚA
class RequiresCraneChanged extends ClientMapBookingInfoEvent {
  final bool value;

  RequiresCraneChanged({
    required this.value,
  });
}

// CARGA FRÁGIL
class FragileCargoChanged extends ClientMapBookingInfoEvent {
  final bool value;

  FragileCargoChanged({
    required this.value,
  });
}

// MAPA
class ChangeMapCameraPosition extends ClientMapBookingInfoEvent {
  final double lat;
  final double lng;

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

// REQUEST
class CreateClientRequest extends ClientMapBookingInfoEvent {}

class GetTimeAndDistanceValues extends ClientMapBookingInfoEvent {}

class AddPolyline extends ClientMapBookingInfoEvent {}

// SOCKET
class EmitNewClientRequestSocketIO extends ClientMapBookingInfoEvent {
  final int idClientRequest;

  EmitNewClientRequestSocketIO({
    required this.idClientRequest,
  });
}