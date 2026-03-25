import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class UserMvcDioRiverpodFormView extends ConsumerStatefulWidget {
  final User? user;

  const UserMvcDioRiverpodFormView({super.key, this.user});

  @override
  ConsumerState<UserMvcDioRiverpodFormView> createState() => _UserMvcDioRiverpodFormViewState();
}

class _UserMvcDioRiverpodFormViewState extends ConsumerState<UserMvcDioRiverpodFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.firstName;
      _jobController.text = 'Developer';
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
      final userController = ref.read(userControllerProvider.notifier);
      bool success;
      
      if (widget.user == null) {
        success = await userController.addUser(
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Menambah user spesifik Dio sukses!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        success = await userController.updateUser(
          widget.user!.id,
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
        if (success && mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Update data spesifik Dio sukses!'),
              backgroundColor: Colors.blue,
            ),
          );
        }
      }

      if (success && mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? 'Riverpod MVC Dio: Tambah' : 'Riverpod MVC Dio: Edit',
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
                    (value) =>
                        !value!.contains('@') ? 'Email tak valid' : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      userState.isLoading ? null : _submitData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child:
                      userState.isLoading
                          ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
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
