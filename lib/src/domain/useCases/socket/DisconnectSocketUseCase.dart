import 'package:localdriver/src/domain/repository/SocketRepository.dart';

class DisconnectSocketUseCase {

  SocketRepository socketRepository;

  DisconnectSocketUseCase(this.socketRepository);

  run() => socketRepository.disconnect();

}