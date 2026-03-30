import 'package:dio/dio.dart';
import '../../../../config/api_constants.dart';
import '../models/user_model.dart';

class ApiService {
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await Dio().get(ApiConstants.baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> userList = response.data['data'];
        final users = userList.map((json) => UserModel.fromJson(json)).toList();
        return users;
      } else {
        throw Exception('Failed to fetch users');
      }
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
