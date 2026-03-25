import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserState {
  final List<User> users;
  final bool isLoading;
  final String errorMessage;

  UserState({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  UserState copyWith({
    List<User>? users,
    bool? isLoading,
    String? errorMessage,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    Future.microtask(() => fetchUsers());
    return UserState();
  }

  UserService get _service => ref.read(userServiceProvider);

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final users = await _service.fetchUsers();
      state = state.copyWith(users: users, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Gagal memuat data: $e',
        isLoading: false,
      );
    }
  }

  Future<bool> addUser(String name, String job, String email) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final newUser = await _service.createUser(name, job, email);
      state = state.copyWith(
        users: [...state.users, newUser],
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Gagal menambah: $e',
        isLoading: false,
      );
      return false;
    }
  }

  Future<bool> updateUser(int id, String name, String job, String email) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final index = state.users.indexWhere((u) => u.id == id);
      if (index == -1) {
        state = state.copyWith(isLoading: false);
        return false;
      }

      final updatedUser = await _service.updateUser(
        id,
        name,
        job,
        email,
        state.users[index],
      );

      final newUsers = [...state.users];
      newUsers[index] = updatedUser;

      state = state.copyWith(users: newUsers, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Gagal membarui: $e',
        isLoading: false,
      );
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      await _service.deleteUser(id);

      final newUsers = state.users.where((u) => u.id != id).toList();
      state = state.copyWith(users: newUsers, isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Gagal menghapus: $e',
        isLoading: false,
      );
      return false;
    }
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(() {
  return UserNotifier();
});
