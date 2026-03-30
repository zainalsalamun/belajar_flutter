import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_bloc.dart';

class UserListView extends StatelessWidget {
  const UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger fetch users when the page loads
    context.read<UserBloc>().add(FetchUsersEvent());

    return Scaffold(
      appBar: AppBar(title: const Text('User List (BLoC MVC API)')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add user form
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSuccessState) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            );
          } else if (state is UserErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Tidak ada data'));
          }
        },
      ),
    );
  }
}
