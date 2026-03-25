import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import 'user_form_view.dart';

class UserMvcApiRiverpodListView extends ConsumerWidget {
  const UserMvcApiRiverpodListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod MVC: Daftar User (API)')),
      body: Builder(
        builder: (context) {
          if (userState.isLoading && userState.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          }

          if (userState.errorMessage.isNotEmpty && userState.users.isEmpty) {
            return Center(child: Text(userState.errorMessage));
          }

          if (userState.users.isEmpty) {
            return const Center(child: Text('Tidak ada data user.'));
          }

          return ListView.builder(
            itemCount: userState.users.length,
            itemBuilder: (context, index) {
              final User user = userState.users[index];
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    UserMvcApiRiverpodFormView(user: user),
                          ),
                        );
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
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      userNotifier.deleteUser(user.id);
                                      Navigator.pop(context);
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserMvcApiRiverpodFormView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
