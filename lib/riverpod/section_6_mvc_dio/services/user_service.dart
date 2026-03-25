import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

// Pastikan sesuaikan import Config dengan kebutuhan.
import '../../../../config/api_constants.dart';

final userServiceProvider = Provider<UserServiceDioRiverpod>((ref) {
  return UserServiceDioRiverpod();
});

class UserServiceDioRiverpod {
  late final Dio _dio;

  UserServiceDioRiverpod() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': ApiConstants.apiKey,
        },
      ),
    );

    // Logging interceptor
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
  }

  Future<List<User>> fetchUsers() async {
    try {
      final response = await _dio.get(
        '/users',
        queryParameters: {'page': 1, 'per_page': 10},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          message: 'Failed load users: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> createUser(String name, String job, String email) async {
    try {
      final response = await _dio.post(
        '/users',
        data: {'name': name, 'job': job, 'email': email},
      );
      if (response.statusCode == 201) {
        final jsonResponse = response.data;
        return User(
          id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
          email: email,
          firstName: name,
          lastName: '',
          avatar: 'https://reqres.in/img/faces/1-image.jpg',
        );
      } else {
        throw Exception('Bad Code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<User> updateUser(
    int id,
    String name,
    String job,
    String email,
    User oldUser,
  ) async {
    try {
      final response = await _dio.put(
        '/users/$id',
        data: {'name': name, 'job': job, 'email': email},
      );
      if (response.statusCode == 200) {
        return User(
          id: id,
          email: email,
          firstName: name,
          lastName: oldUser.lastName,
          avatar: oldUser.avatar,
        );
      } else {
        throw Exception('Bad Code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final response = await _dio.delete('/users/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed deleting');
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    String message = 'Unknown error occurred';
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timed out';
        break;
      case DioExceptionType.badResponse:
        message = 'Server error: ${e.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection';
        break;
      default:
        message = 'Something went wrong: ${e.message}';
    }
    return Exception(message);
  }
}
