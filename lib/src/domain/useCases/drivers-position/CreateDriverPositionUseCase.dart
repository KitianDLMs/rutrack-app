
import 'package:localdriver/src/domain/models/DriverPosition.dart';
import 'package:localdriver/src/domain/repository/DriversPositionRepository.dart';

class CreateDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  CreateDriverPositionUseCase(this.driverPositionRepository);

  run(DriverPosition driverPosition) => driverPositionRepository.create(driverPosition);

}