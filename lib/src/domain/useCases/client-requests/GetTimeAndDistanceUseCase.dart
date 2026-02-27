import 'package:localdriver/src/domain/repository/ClientRequestsRepository.dart';

class GetTimeAndDistanceUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetTimeAndDistanceUseCase(this.clientRequestsRepository);

  run(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) => clientRequestsRepository.getTimeAndDistanceClientRequets(originLat, originLng, destinationLat, destinationLng);

}