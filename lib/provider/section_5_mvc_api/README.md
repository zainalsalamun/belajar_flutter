# Tutorial CRUD dengan Pattern MVC (Model-View-Controller)

Contoh ini menunjukkan cara yang lebih "professional" dan rapi dalam menyusun kode Flutter menggunakan Provider.
Kita memisahkan kode berdasarkan tanggung jawabnya (MVC).

## Struktur Folder yang Rapi

### 1. Model (`models/user_model.dart`)
Berisi **Data Blueprint**. Hanya kode untuk mendefinisikan bentuk data User dan konversi dari/ke JSON. Tidak ada logika aplikasi di sini.

### 2. Service (`services/user_service.dart`)
Berisi **Logika Koneksi API**.
- Fokus hanya melakukan request HTTP (GET, POST, PUT, DELETE).
- Menangani Header (`x-api-key`) dan Parsing JSON dasar.
- Tidak menyimpan State (data tidak disimpan di sini, cuma lewat).

### 3. Controller (`controllers/user_controller.dart`)
Berisi **State Management (Provider)**.
- Ini adalah penghubung antara View dan Service.
- Menyimpan data (`users`, `isLoading`, `error`).
- Memanggil Service untuk ambil data, lalu memberi tahu View untuk update (`notifyListeners`).

### 4. View (`views/`)
Berisi **Tampilan UI**.
- `user_list_view.dart`: Menampilkan daftar.
- `user_form_view.dart`: Form tambah/edit.
- View hanya "mendengarkan" Controller. View tidak boleh melakukan request HTTP langsung.

## Alur Kerja (Flow)
1. **View** (UI) meminta data -> panggil fungsi di **Controller**.
2. **Controller** meminta data mentah -> panggil fungsi di **Service**.
3. **Service** ambil dari Internet (Reqres.in) -> kembalikan ke Controller.
4. **Controller** simpan data ke variable `users` -> panggil `notifyListeners()`.
5. **View** otomatis berubah karena menggunakan `Consumer`.

## Kelebihan Cara Ini
- **Rapi**: Mudah urus kodingan kalau aplikasi makin besar.
- **Mudah Dites**: Kita bisa tes logic (Controller) tanpa harus mikirin tampilan (View).
- **Reusable**: Service bisa dipakai oleh controller lain jika perlu.
