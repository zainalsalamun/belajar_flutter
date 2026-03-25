import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../viewmodels/user_viewmodel.dart';
import 'user_form_view.dart';

class UserMvvmRiverpodListView extends ConsumerWidget {
  const UserMvvmRiverpodListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userViewModelProvider);
    final userViewModel = ref.read(userViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod MVVM: Daftar User')),
      body: userState.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.blue)),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.amber, size: 50),
              Text(error.toString(), textAlign: TextAlign.center),
            ],
          ),
        ),
        data: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('Tidak ada data user.'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final User user = users[index];
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
                            builder: (context) => UserMvvmRiverpodFormView(user: user),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
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
                                  userViewModel.deleteUser(user.id);
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
              builder: (context) => const UserMvvmRiverpodFormView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
