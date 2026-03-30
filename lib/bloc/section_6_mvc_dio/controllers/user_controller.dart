import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/api_constants.dart';
import '../models/user_model.dart';
import 'package:dio/dio.dart';

class UserDioController extends Cubit<List<UserModel>> {
  UserDioController() : super([]) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await Dio().get(ApiConstants.baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> userList = response.data['data'];
        final users = userList.map((json) => UserModel.fromJson(json)).toList();
        emit(users);
      } else {
        // Handle error
        emit([]);
      }
    } catch (e) {
      // Handle error
      emit([]);
    }
  }
}
