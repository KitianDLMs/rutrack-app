import 'package:localdriver/src/domain/repository/GeolocatorRepository.dart';

class CreateMarkerUseCase {

  GeolocatorRepository geolocatorRepository;
  CreateMarkerUseCase(this.geolocatorRepository);
  run(String path) => geolocatorRepository.createMarkerFromAsset(path);
}