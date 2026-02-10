import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';
import 'user_form_view.dart';

class UserListDioView extends StatefulWidget {
  const UserListDioView({super.key});

  @override
  State<UserListDioView> createState() => _UserListDioViewState();
}

class _UserListDioViewState extends State<UserListDioView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserDioController>(context, listen: false).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar User (Dio + MVC)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Consumer<UserDioController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.fetchUsers,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (controller.users.isEmpty) {
            return const Center(child: Text('Tidak ada data user.'));
          }

          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user.avatar),
                    onBackgroundImageError: (_, __) => const Icon(Icons.person),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(user.email, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _navigateToForm(context, user),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed:
                            () => _confirmDelete(context, controller, user),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => _navigateToForm(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _navigateToForm(BuildContext context, [User? user]) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserFormDioView(user: user)),
    );
  }

  void _confirmDelete(
    BuildContext context,
    UserDioController controller,
    User user,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hapus User'),
            content: Text('Yakin ingin menghapus ${user.firstName}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  Navigator.pop(context); // Close dialog
                  final success = await controller.deleteUser(user.id);
                  if (success && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User berhasil dihapus')),
                    );
                  }
                },
                child: const Text('Hapus'),
              ),
            ],
          ),
    );
  }
}
