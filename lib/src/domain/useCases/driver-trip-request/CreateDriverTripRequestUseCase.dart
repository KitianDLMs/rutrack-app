import 'package:localdriver/src/domain/models/DriverTripRequest.dart';
import 'package:localdriver/src/domain/repository/DriverTripRequestsRepository.dart';

class CreateDriverTripRequestUseCase {

  DriverTripRequestsRepository driverTripRequestsRepository;

  CreateDriverTripRequestUseCase(this.driverTripRequestsRepository);

  run(DriverTripRequest driverTripRequest) => driverTripRequestsRepository.create(driverTripRequest);
}