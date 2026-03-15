import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserMvcDioGetxController extends GetxController {
  final UserServiceDioGetx _service = UserServiceDioGetx();

  var users = <User>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      users.value = await _service.fetchUsers();
    } catch (e) {
      errorMessage.value = 'Gagal memuat data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> addUser(String name, String job, String email) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final newUser = await _service.createUser(name, job, email);
      users.add(newUser);
      return true;
    } catch (e) {
      errorMessage.value = 'Gagal menambah: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateUser(int id, String name, String job, String email) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final index = users.indexWhere((u) => u.id == id);
      if (index == -1) return false;

      final updatedUser = await _service.updateUser(
        id,
        name,
        job,
        email,
        users[index],
      );
      users[index] = updatedUser;
      return true;
    } catch (e) {
      errorMessage.value = 'Gagal membarui: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteUser(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _service.deleteUser(id);
      users.removeWhere((u) => u.id == id);
      return true;
    } catch (e) {
      errorMessage.value = 'Gagal menghapus: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
