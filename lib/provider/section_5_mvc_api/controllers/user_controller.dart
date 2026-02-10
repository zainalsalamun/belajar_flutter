import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserController extends ChangeNotifier {
  final UserService _service = UserService();

  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetch users from service
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _service.fetchUsers();
    } catch (e) {
      _error = 'Gagal memuat data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new user
  Future<bool> addUser(String name, String job, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newUser = await _service.createUser(name, job, email);
      _users.add(newUser);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Gagal menambah user: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update an existing user
  Future<bool> updateUser(int id, String name, String job, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final index = _users.indexWhere((u) => u.id == id);
      if (index == -1) return false;

      final updatedUser = await _service.updateUser(
        id,
        name,
        job,
        email,
        _users[index],
      );
      _users[index] = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Gagal update user: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Delete a user
  Future<bool> deleteUser(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service.deleteUser(id);
      _users.removeWhere((u) => u.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Gagal menghapus user: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
