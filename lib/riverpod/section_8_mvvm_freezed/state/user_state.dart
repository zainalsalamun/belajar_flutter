import '../models/user_model.dart';

// Meniru konsep Sealed Class / Union dari Freezed
abstract class UserStateFreezed {
  const UserStateFreezed();

  R when<R>({
    required R Function() loading,
    required R Function(List<User> users) success,
    required R Function(String message) error,
  }) {
    if (this is UserStateLoading) return loading();
    if (this is UserStateSuccess) return success((this as UserStateSuccess).users);
    if (this is UserStateError) return error((this as UserStateError).message);
    throw Exception('Unknown State');
  }
}

class UserStateLoading extends UserStateFreezed {
  const UserStateLoading();
}

class UserStateSuccess extends UserStateFreezed {
  final List<User> users;
  const UserStateSuccess(this.users);
}

class UserStateError extends UserStateFreezed {
  final String message;
  const UserStateError(this.message);
}
