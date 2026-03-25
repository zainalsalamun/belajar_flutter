import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserState {
  final AsyncValue<List<User>> users;

  UserState({required this.users});
}

class UserViewModel extends Notifier<AsyncValue<List<User>>> {
  @override
  AsyncValue<List<User>> build() {
    _fetchUsers();
    return const AsyncValue.loading();
  }

  UserRepository get _repository => ref.read(userRepositoryProvider);

  Future<void> _fetchUsers() async {
    state = const AsyncValue.loading();
    try {
      final users = await _repository.fetchUsers();
      state = AsyncValue.data(users);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<bool> addUser(String name, String job, String email) async {
    try {
      final newUser = await _repository.createUser(name, job, email);

      if (state.hasValue) {
        state = AsyncValue.data([...state.value!, newUser]);
      }
      return true;
    } catch (e) {
      // Handle error natively on UI via snackbar inside View
      return false;
    }
  }

  Future<bool> updateUser(int id, String name, String job, String email) async {
    try {
      if (!state.hasValue) return false;

      final currentUsers = state.value!;
      final index = currentUsers.indexWhere((u) => u.id == id);
      if (index == -1) return false;

      final updatedUser = await _repository.updateUser(
        id, name, job, email, currentUsers[index]
      );

      final newUsers = [...currentUsers];
      newUsers[index] = updatedUser;
      
      state = AsyncValue.data(newUsers);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    try {
      await _repository.deleteUser(id);
      
      if (state.hasValue) {
        final newUsers = state.value!.where((u) => u.id != id).toList();
        state = AsyncValue.data(newUsers);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

final userViewModelProvider = NotifierProvider<UserViewModel, AsyncValue<List<User>>>(() {
  return UserViewModel();
});
