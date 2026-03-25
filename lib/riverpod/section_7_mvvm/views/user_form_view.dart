import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../viewmodels/user_viewmodel.dart';

class UserMvvmRiverpodFormView extends ConsumerStatefulWidget {
  final User? user;

  const UserMvvmRiverpodFormView({super.key, this.user});

  @override
  ConsumerState<UserMvvmRiverpodFormView> createState() => _UserMvvmRiverpodFormViewState();
}

class _UserMvvmRiverpodFormViewState extends ConsumerState<UserMvvmRiverpodFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.firstName;
      _jobController.text = 'Developer'; // Default mock job
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
      setState(() { _isLoading = true; });
      
      final userViewModel = ref.read(userViewModelProvider.notifier);
      bool success;

      if (widget.user == null) {
        success = await userViewModel.addUser(
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
      } else {
        success = await userViewModel.updateUser(
          widget.user!.id,
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
      }

      if (mounted) {
        setState(() { _isLoading = false; });
        if (success) {
          Navigator.pop(context);
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Proses gagal')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? 'Riverpod MVVM: Tambah' : 'Riverpod MVVM: Edit',
        ),
      ),
      body: Padding(
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
                validator: (value) => value!.isEmpty ? 'Nama kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(
                  labelText: 'Pekerjaan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Job kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) => !value!.contains('@') ? 'Email tak valid' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          widget.user == null ? 'Simpan' : 'Update',
                          style: const TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
