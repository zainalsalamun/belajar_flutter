import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import 'user_form_view.dart';

class UserMvcDioGetxListView extends StatelessWidget {
  UserMvcDioGetxListView({super.key});

  final controller = Get.put(UserMvcDioGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX MVC: Daftar User (Dio)')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.users.isEmpty) {
          return const Center(child: Text('Tidak ada data user.'));
        }

        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            final User user = controller.users[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar),
                onBackgroundImageError: (_, __) => const Icon(Icons.person),
              ),
              title: Text('${user.firstName} ${user.lastName}'),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Get.to(() => UserMvcDioGetxFormView(user: user));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Hapus User'),
                              content: const Text(
                                'Apakah Anda yakin ingin menghapus user ini?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.deleteUser(user.id);
                                    Get.back();
                                  },
                                  child: const Text('Hapus'),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const UserMvcDioGetxFormView()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
