import 'package:localdriver/src/domain/models/DriverTripRequest.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

abstract class DriverTripRequestsRepository {

  Future<Resource<bool>> create(DriverTripRequest driverTripRequest);
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest);

}