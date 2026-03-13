import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_controller.dart';
import 'user_model.dart';

class UserFormPageGetx extends StatefulWidget {
  final User? user; // Jika null -> create, jika ada -> update

  const UserFormPageGetx({super.key, this.user});

  @override
  State<UserFormPageGetx> createState() => _UserFormPageGetxState();
}

class _UserFormPageGetxState extends State<UserFormPageGetx> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();

  final UserControllerGetx userController = Get.find<UserControllerGetx>();

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
      bool success;

      if (widget.user == null) {
        // Create Data
        success = await userController.addUser(
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
        if (success && mounted) {
          Get.snackbar(
            'Sukses',
            'User berhasil ditambahkan',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } else {
        // Update Data
        success = await userController.updateUser(
          widget.user!.id,
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
        if (success && mounted) {
          Get.snackbar(
            'Sukses',
            'User berhasil diupdate',
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        }
      }

      // Kembali jika berhasil
      if (success && mounted) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? 'GetX: Tambah User' : 'GetX: Edit User',
        ),
      ),
      body: Obx(() {
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
                    onPressed:
                        userController.isLoading.value ? null : _submitData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child:
                        userController.isLoading.value
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
      }),
    );
  }
}
