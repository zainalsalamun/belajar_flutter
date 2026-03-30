import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../../config/api_constants.dart';
import '../models/user_model.dart';

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
  final List<UserModel> users;
  UserSuccessState(this.users);
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final Dio _dio = Dio();

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
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/users?page=1&per_page=10',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        final List<dynamic> data = jsonResponse['data'];
        final users = data.map((json) => UserModel.fromJson(json)).toList();
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
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/users',
        data: json.encode({
          'name': event.name,
          'job': event.job,
          'email': event.email,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        final jsonResponse = response.data;
        final newUser = UserModel(
          id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
          name: event.name,
          email: event.email,
        );

        // Get current users list
        final currentState = state;
        if (currentState is UserSuccessState) {
          final updatedUsers = List<UserModel>.from(currentState.users)
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
      final response = await _dio.put(
        '${ApiConstants.baseUrl}/users/${event.id}',
        data: json.encode({
          'name': event.name,
          'job': event.job,
          'email': event.email,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final currentState = state;
        if (currentState is UserSuccessState) {
          final index = currentState.users.indexWhere((u) => u.id == event.id);
          if (index != -1) {
            final updatedUser = UserModel(
              id: event.id,
              name: event.name,
              email: event.email,
            );
            final updatedUsers = List<UserModel>.from(currentState.users);
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
      final response = await _dio.delete(
        '${ApiConstants.baseUrl}/users/${event.id}',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 204) {
        final currentState = state;
        if (currentState is UserSuccessState) {
          final updatedUsers = List<UserModel>.from(currentState.users)
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

final userBlocProvider = BlocProvider<UserBloc>(create: (_) => UserBloc());
