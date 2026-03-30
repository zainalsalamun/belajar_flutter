import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class UserViewModel extends Cubit<List<UserModel>> {
  final ApiService _apiService = ApiService();

  UserViewModel() : super([]) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _apiService.getUsers();
      emit(users);
    } catch (e) {
      // Handle error
      emit([]);
    }
  }
}
