import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final userRepositoryProvider = Provider((ref) {
  return UserRepository(ref.read(apiServiceProvider));
});

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _apiService.dio.get(
        '/users',
        queryParameters: {'page': 1, 'per_page': 10},
      );
      final List<dynamic> data = response.data['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Gagal menarik data: ${e.message}');
    }
  }

  Future<User> createUser(String name, String job, String email) async {
    try {
      final response = await _apiService.dio.post(
        '/users',
        data: {'name': name, 'job': job, 'email': email},
      );
      final jsonResponse = response.data;
      return User(
        id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
        email: email,
        firstName: name,
        lastName: '',
        avatar: 'https://reqres.in/img/faces/1-image.jpg',
      );
    } on DioException catch (e) {
      throw Exception('Gagal menambahkan user: ${e.message}');
    }
  }

  Future<User> updateUser(int id, String name, String job, String email, User oldUser) async {
    try {
      await _apiService.dio.put(
        '/users/$id',
        data: {'name': name, 'job': job, 'email': email},
      );
      return oldUser.copyWith(
        email: email,
        firstName: name,
      );
    } on DioException catch (e) {
      throw Exception('Gagal update user: ${e.message}');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _apiService.dio.delete('/users/$id');
    } on DioException catch (e) {
      throw Exception('Gagal hapus user: ${e.message}');
    }
  }
}
