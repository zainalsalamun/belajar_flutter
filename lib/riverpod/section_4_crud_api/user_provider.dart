import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_model.dart';
import '../../config/api_constants.dart';

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
  final String _baseUrl = '${ApiConstants.baseUrl}/users';

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.apiKey,
      };

  @override
  UserState build() {
    Future.microtask(() => fetchUsers());
    return UserState();
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?page=1&per_page=10'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        final users = data.map((json) => User.fromJson(json)).toList();
        state = state.copyWith(users: users, isLoading: false);
      } else {
        state = state.copyWith(
          errorMessage: 'Gagal mengambil data. Status: ${response.statusCode}',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Terjadi kesalahan: $e',
        isLoading: false,
      );
    }
  }

  Future<bool> addUser(String name, String job, String email) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: json.encode({'name': name, 'job': job, 'email': email}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final newUser = User(
          id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
          email: email,
          firstName: name,
          lastName: '',
          avatar: 'https://reqres.in/img/faces/1-image.jpg',
        );

        state = state.copyWith(
          users: [...state.users, newUser],
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          errorMessage: 'Gagal menambahkan user. Status: ${response.statusCode}',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Terjadi kesalahan: $e',
        isLoading: false,
      );
    }
    return false;
  }

  Future<bool> updateUser(int id, String name, String job, String email) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: _headers,
        body: json.encode({'name': name, 'job': job, 'email': email}),
      );

      if (response.statusCode == 200) {
        final index = state.users.indexWhere((user) => user.id == id);
        if (index != -1) {
          final updatedUser = User(
            id: id,
            email: email,
            firstName: name,
            lastName: state.users[index].lastName,
            avatar: state.users[index].avatar,
          );
          
          final newUsers = [...state.users];
          newUsers[index] = updatedUser;
          
          state = state.copyWith(users: newUsers, isLoading: false);
          return true;
        }
      } else {
        state = state.copyWith(
          errorMessage: 'Gagal mengupdate user. Status: ${response.statusCode}',
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Terjadi kesalahan: $e',
        isLoading: false,
      );
    }
    return false;
  }

  Future<bool> deleteUser(int id) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        final newUsers = state.users.where((user) => user.id != id).toList();
        state = state.copyWith(users: newUsers, isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          errorMessage: 'Gagal menghapus user. Status: ${response.statusCode}',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Terjadi kesalahan: $e',
        isLoading: false,
      );
    }
    return false;
  }
}

final userNotifierProvider = NotifierProvider<UserNotifier, UserState>(() {
  return UserNotifier();
});
