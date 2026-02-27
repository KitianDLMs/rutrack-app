import 'package:localdriver/src/domain/repository/SocketRepository.dart';

class ConnectSocketUseCase {

  SocketRepository socketRepository;

  ConnectSocketUseCase(this.socketRepository);

  run() => socketRepository.connect();

}