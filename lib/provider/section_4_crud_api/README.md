# Dokumentasi Section 4: CRUD API (ReqRes.in)

Folder ini berisi tingkat lanjutan dari penerapan state management Provider dengan menambahkan simulasi komunikasi jaringan (networking) ke Public API **[ReqRes.in](https://reqres.in/)**. Modul ini mengajarkan konsep dasar melakukan operasi CRUD (Create, Read, Update, Delete) melalui protokol HTTP.

Secara default, implementasi ini sudah cukup baik untuk prototype sederhana, meski belum dipecah ke dalam abstraksi Layer (Model-View-Controller murni) seperti di bagian 5 dan 6.

## Struktur Kode

### 1. Model (`user_model.dart`)
Kelas representasi data yang berfungsi sebagai cetakan (blueprint) untuk objek `User` yang kita ambil dari API.

```dart
class User {
  final int id;
  final String email;
  final String firstName;
  ...

  // Fungsi konversi (mapping) dari JSON map menjadi Object Dart
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      ...
    );
  }
}
```
* **Catatan**: Format JSON mentah yang berbentuk key-value string (seperti dari backend) wajib ditransformasi menjadi Object Dart untuk menjamin *Type Safety*.

### 2. Provider / Logika Bisnis (`user_provider.dart`)
Berperan sebagai "Otak Utama" (atau semi-Controller). Ia tidak hanya menyimpan state, tapi juga langsung mengolah *HTTP Request* (penyisipan header, eksekusi Endpoint, hingga konversi JSON response).

```dart
class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  // READ: Fetch GET Data dari server
  Future<void> fetchUsers() async {
    _isLoading = true; // Set indikator loading nyala
    notifyListeners(); // Refresh UI UI merender indikator putaran loading

    try {
      final response = await http.get(Uri.parse('$_baseUrl?page=1&per_page=10'));
      if (response.statusCode == 200) {
        ... // Decode json response dan convert jadi list User
      }
    } catch (e) {
      ... // Handle error message
    } finally {
      _isLoading = false; // Matikan indikator loading
      notifyListeners();  // Refresh UI lagi untuk matikan animasi loading dan merender list users    }
  }
}
```
* **HTTP Methods**: Terdapat fungsi Create (POST), Read (GET), Update (PUT/PATCH), Delete (DELETE). Karena ini merupakan API Dummy (reqres.in), perubahan data **tidak tersimpan memori server mereka secara permanen**. Fungsi di file ini melakukan manipulasi Array list lokal (_users.add, _users.indexWhere, dll) untuk mensimulasikan CRUD pada UI klien.

### 3. Tampilan UI (`user_list_page.dart` & `user_form_page.dart`)
View (UI) mendengarkan status Provider menggunakan `Consumer<UserProvider>`.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Consumer<UserProvider>(
      builder: (context, provider, child) {
        // Kontrol tampilan berdasarkan 'State' yang disuplai oleh provider
        if (provider.isLoading) {
          return const CircularProgressIndicator();
        }

        if (provider.error != null) {
          return Text(provider.error!);
        }

        // Tampilkan daftar List View
        return ListView.builder(...)
      }
    )
  );
}
```
* **`initState` Fetching**: Di dalam `user_list_page.dart`, data diambil segera setelah halaman dirender dengan cara memanfaatkan `Future.microtask` di dalam block override `initState()`.

## Kenapa Konsep ini Penting?

1. **Memahami Integrasi Client-Server**: Mengajarkan bagaimana alur pertukaran JSON dengan endpoint RESTful API.
2. **State Interaktivitas & Penanganan Error**: Menangani UX standar industri ketika menanti proses asinkronus (menampilkan _Loading Indicator_, serta _Error Message_ jika koneksi putus atau request gagal).
3. **Mengubah JSON ke Object**: Latihan transisi data mapping (serialization/deserialization) yang mutlak dikerjakan pada komunikasi API. 
4. **Local State Simulation**: Teknik memanipulasi List lokal Dart dengan `add`, `removeWhere`, `indexWhere` sangat berguna bahkan untuk menyimpan data secara luring.
