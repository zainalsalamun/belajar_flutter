import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_bloc.dart';
import 'user_model.dart';

class UserFormPageBloc extends StatefulWidget {
  final User? user; // Jika null -> create, jika ada -> update

  const UserFormPageBloc({super.key, this.user});

  @override
  State<UserFormPageBloc> createState() => _UserFormPageBlocState();
}

class _UserFormPageBlocState extends State<UserFormPageBloc> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Kalau update, isi nilai form
    if (widget.user != null) {
      _nameController.text = widget.user!.firstName;
      _jobController.text = 'Developer'; // Default Dummy Job
      _emailController.text = widget.user!.email;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      bool success = false;

      if (widget.user == null) {
        // Create Data
        context.read<UserBloc>().add(
          AddUserEvent(
            _nameController.text,
            _jobController.text,
            _emailController.text,
          ),
        );
        success = true;
      } else {
        // Update Data
        context.read<UserBloc>().add(
          UpdateUserEvent(
            widget.user!.id,
            _nameController.text,
            _jobController.text,
            _emailController.text,
          ),
        );
        success = true;
      }

      // Kembali jika berhasil
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.user == null
                  ? 'User berhasil ditambahkan'
                  : 'User berhasil diupdate',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? 'Bloc: Tambah User' : 'Bloc: Edit User',
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Nama tidak boleh kosong'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _jobController,
                    decoration: const InputDecoration(
                      labelText: 'Pekerjaan',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Pekerjaan tidak boleh kosong'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Email tidak boleh kosong';
                      if (!value.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is UserLoadingState ? null : _submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child:
                          state is UserLoadingState
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                widget.user == null ? 'Simpan' : 'Update',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
