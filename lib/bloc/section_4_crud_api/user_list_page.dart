import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_bloc.dart';
import 'user_model.dart';
import 'user_form_page.dart';

class UserListPageBloc extends StatelessWidget {
  const UserListPageBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(FetchUsersEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Bloc: Daftar User (CRUD API)')),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            }

            if (state is UserErrorState) {
              return Center(child: Text(state.message));
            }

            if (state is UserSuccessState) {
              if (state.users.isEmpty) {
                return const Center(child: Text('Tidak ada data user.'));
              }

              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final User user = state.users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      onBackgroundImageError:
                          (_, __) => const Icon(Icons.person),
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
                                    (context) => UserFormPageBloc(user: user),
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
                                          context.read<UserBloc>().add(
                                            DeleteUserEvent(user.id),
                                          );
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
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserFormPageBloc()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
