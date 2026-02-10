import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

import '../../../config/api_constants.dart';

class UserService {
  final String _baseUrl = '${ApiConstants.baseUrl}/users';

  // HTTP Headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };

  /// Fetch list of users
  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl?page=1&per_page=10'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  /// Create a new user
  Future<User> createUser(String name, String job, String email) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: _headers,
      body: json.encode({'name': name, 'job': job, 'email': email}),
    );

    if (response.statusCode == 201) {
      final jsonResponse = json.decode(response.body);
      return User(
        id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
        email: email,
        firstName: name,
        lastName: '',
        avatar: 'https://reqres.in/img/faces/1-image.jpg',
      );
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  /// Update an existing user
  Future<User> updateUser(
    int id,
    String name,
    String job,
    String email,
    User oldUser,
  ) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: _headers,
      body: json.encode({'name': name, 'job': job, 'email': email}),
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
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  /// Delete a user
  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: _headers,
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }
}
