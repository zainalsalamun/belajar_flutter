import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/user_viewmodel.dart';
import '../models/user_model.dart';

class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List (BLoC MVVM)')),
      body: BlocBuilder<UserViewModel, List<UserModel>>(
        builder: (context, users) {
          if (users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
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
        },
      ),
    );
  }
}
