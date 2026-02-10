import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

import '../../config/api_constants.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Base URL dari reqres.in
  final String _baseUrl = '${ApiConstants.baseUrl}/users';

  // Header standar untuk request API
  // Beberapa server memblokir request tanpa User-Agent
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };

  // CREATE: Menambahkan user baru
  // API: POST /api/users
  Future<bool> addUser(String name, String job, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _headers,
        body: json.encode({'name': name, 'job': job, 'email': email}),
      );

      if (response.statusCode == 201) {
        // Karena ini API dummy, data tidak benar-benar tersimpan di server.
        // Kita simulasi tambahkan ke list lokal agar terlihat di UI.
        final jsonResponse = json.decode(response.body);

        // Buat object user baru dari response
        // Note: Reqres response create cuma balikin id, createdAt.
        // Kita mock data lain supaya tidak null.
        final newUser = User(
          id: int.tryParse(jsonResponse['id'].toString()) ?? 0,
          email: email,
          firstName: name,
          lastName: '',
          avatar: 'https://reqres.in/img/faces/1-image.jpg', // Dummy avatar
        );

        _users.add(newUser);
        notifyListeners();
        return true;
      } else {
        _error = 'Gagal menambahkan user. Status: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  // READ: Mengambil daftar user
  // API: GET /api/users
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Kita ambil page 1 saja untuk contoh sederhana
      final response = await http.get(
        Uri.parse('$_baseUrl?page=1&per_page=10'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        _users = data.map((json) => User.fromJson(json)).toList();
      } else {
        _error = 'Gagal mengambil data. Status: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // UPDATE: Mengupdate data user
  // API: PUT /api/users/{id}
  Future<bool> updateUser(int id, String name, String job, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: _headers,
        body: json.encode({'name': name, 'job': job, 'email': email}),
      );

      if (response.statusCode == 200) {
        // Update user di list lokal
        final index = _users.indexWhere((user) => user.id == id);
        if (index != -1) {
          // Kita buat object baru dengan data yang diupdate
          // Note: response reqres update cuma balikin updatedAt.
          final updatedUser = User(
            id: id,
            email: email,
            firstName: name, // Update nama
            lastName: _users[index].lastName,
            avatar: _users[index].avatar,
          );
          _users[index] = updatedUser;
        }
        notifyListeners();
        return true;
      } else {
        _error = 'Gagal mengupdate user. Status: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  // DELETE: Menghapus user
  // API: DELETE /api/users/{id}
  Future<bool> deleteUser(int id) async {
    // Kita bisa set loading true jika mau, tapi untuk delete list biasanya
    // kita optimis hapus dari list, atau tampilkan indicator di item nya.
    // Disini kita pakai loading global sederhana.
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        // Hapus dari list lokal
        _users.removeWhere((user) => user.id == id);
        notifyListeners();
        return true;
      } else {
        _error = 'Gagal menghapus user. Status: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }
}
