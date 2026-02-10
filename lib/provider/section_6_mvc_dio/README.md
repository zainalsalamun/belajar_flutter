# Tutorial CRUD dengan Dio + Provider (MVC Pattern)

Contoh ini mirip dengan Section 5, tetapi menggunakan **Dio** sebagai ganti `http` package.
Dio adalah HTTP client yang lebih powerful untuk Flutter/Dart, mendukung interceptors, global configuration, form data, file downloading, dll.

## Struktur Folder (MVC)

### 1. Model (`models/user_model.dart`)
Sama seperti sebelumnya, representasi data User.

### 2. Service (`services/user_service.dart`)
Berisi logika koneksi API menggunakan **Dio**.
- Menggunakan `BaseOptions` untuk konfigurasi URL dan Header global.
- Menangani `DioException` untuk error handling yang lebih spesifik.
- Menggunakan `LogInterceptor` untuk melihat log request/response di console (sangat berguna untuk debugging).

### 3. Controller (`controllers/user_controller.dart`)
State Management menggunakan Provider.
- Memanggil `UserService`.
- Mengubah state (`users`, `isLoading`, `error`) dan memberitahu UI.

### 4. View (`views/`)
Tampilan UI yang mendengarkan `UserDioController`.

## Kelebihan Dio
- **Interceptors**: Bisa menyisipkan logika sebelum request dikirim atau setelah response diterima (misal: otomatis refresh token, logging).
- **Less Boilerplate**: Response otomatis diparsing menjadi JSON (Map/List), tidak perlu `json.decode` manual.
- **Error Handling**: `DioException` memberikan info error yang lebih detail (timeout, response status, dll).

## Cara Menggunakan
1. Pastikan pilih menu "6. MVC Pattern + Dio".
2. Cek console/terminal saat melakukan request, Anda akan melihat log detail dari Dio.
