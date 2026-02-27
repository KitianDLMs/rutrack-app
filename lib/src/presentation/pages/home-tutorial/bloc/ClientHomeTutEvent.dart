abstract class ClientHomeTutEvent {}

class ChangeDrawerPage extends ClientHomeTutEvent {
  final int pageIndex;
  ChangeDrawerPage({ required this.pageIndex });
}

class Logout extends ClientHomeTutEvent {}