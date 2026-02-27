import 'package:localdriver/src/data/dataSource/remote/services/DriverTripRequestsService.dart';
import 'package:localdriver/src/domain/models/DriverTripRequest.dart';
import 'package:localdriver/src/domain/repository/DriverTripRequestsRepository.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class DriverTripRequestsRepositoryImpl implements DriverTripRequestsRepository {
  
  DriverTripRequestsService driverTripRequestsService;

  DriverTripRequestsRepositoryImpl(this.driverTripRequestsService);

  @override
  Future<Resource<bool>> create(DriverTripRequest driverTripRequest) {
    return driverTripRequestsService.create(driverTripRequest);
  }
  
  @override
  Future<Resource<List<DriverTripRequest>>> getDriverTripOffersByClientRequest(int idClientRequest) {
    return driverTripRequestsService.getDriverTripOffersByClientRequest(idClientRequest);
  }

}