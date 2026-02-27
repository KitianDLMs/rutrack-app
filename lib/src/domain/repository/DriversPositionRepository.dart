import 'package:localdriver/src/domain/models/DriverPosition.dart';
import 'package:localdriver/src/domain/utils/Resource.dart';

abstract class DriverPositionRepository {

  Future<Resource<bool>> create(DriverPosition driverPosition);
  Future<Resource<bool>> delete(int idDriver);
  Future<Resource<DriverPosition>> getDriverPosition(int idDriver);

}