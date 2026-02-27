import 'package:equatable/equatable.dart';

class ClientHomeTutState extends Equatable {

  final int pageIndex;

  ClientHomeTutState({
    this.pageIndex = 0
  });

  ClientHomeTutState copyWith({
    int? pageIndex
  }) {
    return ClientHomeTutState(pageIndex: pageIndex ?? this.pageIndex);
  }

  @override
  List<Object?> get props => [pageIndex];

}