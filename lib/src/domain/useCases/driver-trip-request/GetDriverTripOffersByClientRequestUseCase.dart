import 'package:localdriver/src/domain/repository/DriverTripRequestsRepository.dart';

class GetDriverTripOffersByClientRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  GetDriverTripOffersByClientRequestUseCase(this.driverTripRequestsRepository);

  run(int idClientRequest) => driverTripRequestsRepository.getDriverTripOffersByClientRequest(idClientRequest);

}