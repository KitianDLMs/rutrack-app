
import 'package:localdriver/src/domain/models/DriverPosition.dart';
import 'package:localdriver/src/domain/repository/DriversPositionRepository.dart';

class DeleteDriverPositionUseCase {

  DriverPositionRepository driverPositionRepository;

  DeleteDriverPositionUseCase(this.driverPositionRepository);

  run(int idDriver) => driverPositionRepository.delete(idDriver);

}