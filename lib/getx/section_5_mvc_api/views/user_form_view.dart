import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../controllers/user_controller.dart';

class UserMvcApiGetxFormView extends StatefulWidget {
  final User? user;

  const UserMvcApiGetxFormView({super.key, this.user});

  @override
  State<UserMvcApiGetxFormView> createState() => _UserMvcApiGetxFormViewState();
}

class _UserMvcApiGetxFormViewState extends State<UserMvcApiGetxFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();
  final _emailController = TextEditingController();

  final UserMvcApiGetxController userController =
      Get.find<UserMvcApiGetxController>();

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
      bool success;
      if (widget.user == null) {
        success = await userController.addUser(
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
        if (success) {
          Get.snackbar(
            'Berhasil',
            'Menambah data sukses!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } else {
        success = await userController.updateUser(
          widget.user!.id,
          _nameController.text,
          _jobController.text,
          _emailController.text,
        );
        if (success) {
          Get.snackbar(
            'Berhasil',
            'Update data sukses!',
            backgroundColor: Colors.blue,
            colorText: Colors.white,
          );
        }
      }

      if (success) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.user == null ? 'GetX MVC: Tambah' : 'GetX MVC: Edit',
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
                              style: const TextStyle(color: Colors.white),
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
