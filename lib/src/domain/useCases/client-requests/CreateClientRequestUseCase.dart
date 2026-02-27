import 'package:localdriver/src/domain/models/ClientRequest.dart';
import 'package:localdriver/src/domain/repository/ClientRequestsRepository.dart';

class CreateClientRequestUseCase {

  ClientRequestsRepository clientRequestsRepository;

  CreateClientRequestUseCase(this.clientRequestsRepository);

  run(ClientRequest clientRequest) => clientRequestsRepository.create(clientRequest);

}