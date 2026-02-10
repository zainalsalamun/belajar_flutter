import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class UserFormView extends StatefulWidget {
  final User? user;

  const UserFormView({super.key, this.user});

  @override
  State<UserFormView> createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _jobController;
  late TextEditingController _emailController;

  bool get _isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.firstName ?? '');
    _jobController = TextEditingController(text: 'Programmer'); // Default job
    _emailController = TextEditingController(text: widget.user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit User' : 'Tambah User'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Consumer<UserController>(
            builder: (context, controller, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Nama wajib diisi'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _jobController,
                    decoration: const InputDecoration(
                      labelText: 'Pekerjaan',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Pekerjaan wajib diisi'
                                : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Email wajib diisi';
                      if (!value.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),

                  if (controller.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => _submitForm(controller),
                      child: Text(
                        _isEditing ? 'UPDATE' : 'SIMPAN',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  if (controller.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        controller.error!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm(UserController controller) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final job = _jobController.text;
      final email = _emailController.text;

      bool success;
      if (_isEditing) {
        success = await controller.updateUser(
          widget.user!.id,
          name,
          job,
          email,
        );
      } else {
        success = await controller.addUser(name, job, email);
      }

      if (success && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan')));
        Navigator.pop(context);
      }
    }
  }
}
