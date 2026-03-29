import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';
import '../../config/api_constants.dart';

// Events
abstract class UserEvent {}

class FetchUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final String name;
  final String job;
  final String email;
  AddUserEvent(this.name, this.job, this.email);
}

class UpdateUserEvent extends UserEvent {
  final int id;
  final String name;
  final String job;
  final String email;
  UpdateUserEvent(this.id, this.name, this.job, this.email);
}

class DeleteUserEvent extends UserEvent {
  final int id;
  DeleteUserEvent(this.id);
}

// States
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final List<User> users;
  UserSuccessState(this.users);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final String _baseUrl = '${ApiConstants.baseUrl}/users';

  Map<String, String> get _headers => {'Content-Type': 'application/json'};

  UserBloc() : super(UserInitialState()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<AddUserEvent>(_onAddUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onFetchUsers(
    FetchUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?page=1&per_page=10'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        final users = data.map((json) => User.fromJson(json)).toList();
        emit(UserSuccessState(users));
      } else {
        emit(UserErrorState('Gagal mengambil data: ${response.statusCode}'));
      }
    } catch (e) {
      emit(UserErrorState('Terjadi kesalahan: $e'));
    }
  }

  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: json.encode({
          'name': event.name,
          'job': event.job,
          'email': event.email,
        }),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final newUser = User(
          id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
          email: event.email,
          firstName: event.name,
          lastName: '',
          avatar: 'https://reqres.in/img/faces/1-image.jpg',
        );

        // Get current users list
        final currentState = state;
        if (currentState is UserSuccessState) {
          final updatedUsers = List<User>.from(currentState.users)
            ..add(newUser);
          emit(UserSuccessState(updatedUsers));
        } else {
          emit(UserSuccessState([newUser]));
        }
      } else {
        emit(
          UserErrorState(
            'Gagal menambahkan user. Status: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(UserErrorState('Terjadi kesalahan: $e'));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/${event.id}'),
        headers: _headers,
        body: json.encode({
          'name': event.name,
          'job': event.job,
          'email': event.email,
        }),
      );

      if (response.statusCode == 200) {
        final currentState = state;
        if (currentState is UserSuccessState) {
          final index = currentState.users.indexWhere((u) => u.id == event.id);
          if (index != -1) {
            final updatedUser = User(
              id: event.id,
              email: event.email,
              firstName: event.name,
              lastName: currentState.users[index].lastName,
              avatar: currentState.users[index].avatar,
            );
            final updatedUsers = List<User>.from(currentState.users);
            updatedUsers[index] = updatedUser;
            emit(UserSuccessState(updatedUsers));
          }
        }
      } else {
        emit(UserErrorState('Gagal update user: ${response.statusCode}'));
      }
    } catch (e) {
      emit(UserErrorState('Terjadi kesalahan: $e'));
    }
  }

  Future<void> _onDeleteUser(
    DeleteUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/${event.id}'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        final currentState = state;
        if (currentState is UserSuccessState) {
          final updatedUsers = List<User>.from(currentState.users)
            ..removeWhere((u) => u.id == event.id);
          emit(UserSuccessState(updatedUsers));
        }
      } else {
        emit(UserErrorState('Gagal menghapus user: ${response.statusCode}'));
      }
    } catch (e) {
      emit(UserErrorState('Terjadi kesalahan: $e'));
    }
  }
}
