import 'package:localdriver/src/domain/models/DriverCarInfo.dart';
import 'package:localdriver/src/domain/repository/DriverCarInfoRepository.dart';

class GetDriverCarInfoUseCase {

  DriverCarInfoRepository driverCarInfoRepository;
  GetDriverCarInfoUseCase(this.driverCarInfoRepository);
  run(int idDriver) => driverCarInfoRepository.getDriverCarInfo(idDriver);
}