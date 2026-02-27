import 'package:localdriver/src/domain/repository/ClientRequestsRepository.dart';

class GetByClientAssignedUseCase {

  ClientRequestsRepository clientRequestsRepository;

  GetByClientAssignedUseCase(this.clientRequestsRepository);

  run(int idClient) => clientRequestsRepository.getByClientAssigned(idClient);

}