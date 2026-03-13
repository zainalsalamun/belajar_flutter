import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

import '../../config/api_constants.dart';

class UserControllerGetx extends GetxController {
  // rx variables
  var users = <User>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs; // Kosong jika tidak ada error

  final String _baseUrl = '${ApiConstants.baseUrl}/users';

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-api-key': ApiConstants.apiKey,
  };

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Dipanggil saat controller diinisiasi (biasanya saat route masuk)
  }

  // CREATE
  Future<bool> addUser(String name, String job, String email) async {
    isLoading.value = true;
    errorMessage.value = '';

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

        users.add(newUser);
        return true;
      } else {
        errorMessage.value =
            'Gagal menambahkan user. Status: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  // READ
  Future<void> fetchUsers() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?page=1&per_page=10'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];

        // Assign RxList langsung mengganti data yg ada di array.
        users.value = data.map((json) => User.fromJson(json)).toList();
      } else {
        errorMessage.value = 'Gagal mengambil data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // UPDATE
  Future<bool> updateUser(int id, String name, String job, String email) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: _headers,
        body: json.encode({'name': name, 'job': job, 'email': email}),
      );

      if (response.statusCode == 200) {
        final index = users.indexWhere((u) => u.id == id);
        if (index != -1) {
          final updatedUser = User(
            id: id,
            email: email,
            firstName: name,
            lastName: users[index].lastName,
            avatar: users[index].avatar,
          );
          users[index] = updatedUser; // Update element list local rxList
        }
        return true;
      } else {
        errorMessage.value = 'Gagal update user: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  // DELETE
  Future<bool> deleteUser(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
        headers: _headers,
      );

      if (response.statusCode == 204) {
        users.removeWhere((u) => u.id == id);
        return true;
      } else {
        errorMessage.value = 'Gagal menghapus user: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading.value = false;
    }
    return false;
  }
}
