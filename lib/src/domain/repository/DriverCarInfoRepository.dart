import 'package:localdriver/src/domain/models/DriverCarInfo.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

abstract class DriverCarInfoRepository {

  Future<Resource<bool>> create(DriverCarInfo driverCarInfo);
  Future<Resource<DriverCarInfo>> getDriverCarInfo(int idDriver);

}