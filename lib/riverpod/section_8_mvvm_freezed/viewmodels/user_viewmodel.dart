import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_repository.dart';
import '../state/user_state.dart';

class UserViewModelFreezed extends Notifier<UserStateFreezed> {
  @override
  UserStateFreezed build() {
    _fetchUsers();
    return const UserStateLoading();
  }

  UserRepository get _repository => ref.read(userRepositoryProvider);

  Future<void> _fetchUsers() async {
    state = const UserStateLoading();
    try {
      final users = await _repository.fetchUsers();
      state = UserStateSuccess(users);
    } catch (e) {
      state = UserStateError('Gagal menarik data: $e');
    }
  }

  Future<bool> addUser(String name, String job, String email) async {
    try {
      final newUser = await _repository.createUser(name, job, email);

      if (state is UserStateSuccess) {
        final currentUsers = (state as UserStateSuccess).users;
        state = UserStateSuccess([...currentUsers, newUser]);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(int id, String name, String job, String email) async {
    try {
      if (state is! UserStateSuccess) return false;

      final currentUsers = (state as UserStateSuccess).users;
      final index = currentUsers.indexWhere((u) => u.id == id);
      if (index == -1) return false;

      final updatedUser = await _repository.updateUser(
        id, name, job, email, currentUsers[index]
      );

      final newUsers = [...currentUsers];
      newUsers[index] = updatedUser;
      
      state = UserStateSuccess(newUsers);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    try {
      if (state is! UserStateSuccess) return false;
      await _repository.deleteUser(id);
      
      final currentUsers = (state as UserStateSuccess).users;
      final newUsers = currentUsers.where((u) => u.id != id).toList();
      state = UserStateSuccess(newUsers);
      
      return true;
    } catch (e) {
      return false;
    }
  }
}

final userViewModelFreezedProvider = NotifierProvider<UserViewModelFreezed, UserStateFreezed>(() {
  return UserViewModelFreezed();
});
