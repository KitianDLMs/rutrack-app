import 'package:localdriver/src/data/dataSource/remote/services/DriverCarInfoService.dart';
import 'package:localdriver/src/domain/models/DriverCarInfo.dart';
import 'package:localdriver/src/domain/repository/DriverCarInfoRepository.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

class DriverCarInfoRepositoryImpl implements DriverCarInfoRepository{

  DriverCarInfoService driverCarInfoService;

  DriverCarInfoRepositoryImpl(this.driverCarInfoService);

  @override
  Future<Resource<bool>> create(DriverCarInfo driverCarInfo) {
    return driverCarInfoService.create(driverCarInfo);
  }

  @override
  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver) {
    return driverCarInfoService.getDriverCarInfo(idDriver);
  }



}