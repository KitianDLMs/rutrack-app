import 'package:localdriver/src/domain/models/user.dart';

class ProfileInfoState {

  final User? user;
  final bool success;

  ProfileInfoState({
    this.user,
    this.success = false
  });

  ProfileInfoState copyWith({
    User? user,
    bool? success
  }) {
    return ProfileInfoState(
      user: user ?? this.user,
      success: success ?? this.success
    );
  }
}