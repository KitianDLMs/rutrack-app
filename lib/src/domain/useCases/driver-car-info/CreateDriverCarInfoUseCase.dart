import 'package:localdriver/src/domain/models/DriverCarInfo.dart';
import 'package:localdriver/src/domain/repository/DriverCarInfoRepository.dart';

class CreateDriverCarInfoUseCase {

  DriverCarInfoRepository driverCarInfoRepository;
  CreateDriverCarInfoUseCase(this.driverCarInfoRepository);
  run(DriverCarInfo driverCarInfo) => driverCarInfoRepository.create(driverCarInfo);
}