# Tutorial CRUD Sederhana dengan Provider dan API (ReqRes.in)

Ini adalah contoh aplikasi sederhana untuk melakukan operasi CRUD (Create, Read, Update, Delete) menggunakan state management **Provider** dan API public **ReqRes.in**.

## Struktur Folder
Di dalam folder ini terdapat 3 file utama:
1.  **user_model.dart**: Model data (representasi data User).
2.  **user_provider.dart**: Otak aplikasi (mengelola data dan komunikasi ke API).
3.  **user_list_page.dart** & **user_form_page.dart**: Tampilan UI.

## Penjelasan Singkat untuk Pemula

### 1. User Model (`user_model.dart`)
Bayangkan ini sebagai "cetakan kue". Kita memberi tahu aplikasi bentuk data "User" itu seperti apa.
- Punya nama depan, nama belakang, email, dan foto.
- Kita ubah data dari format JSON (dari internet) menjadi object yang bisa dimengerti code Flutter.

### 2. User Provider (`user_provider.dart`)
Ini adalah "Pelayan Restoran" kita.
- Dia yang mencatat pesanan (State: users, isLoading).
- Dia yang ke dapur (API ReqRes.in) untuk mengambil, menambah, atau mengubah pesanan.
- Ketika dia kembali dari dapur membawa makanan, dia berteriak "Makanan siap!" (`notifyListeners()`) supaya pelanggan (UI) tahu dan bisa memakan (menampilkan) makanannya.

### 3. Tampilan UI (`user_list_page.dart` & `user_form_page.dart`)
Ini adalah "Pelanggan".
- Menggunakan `Consumer<UserProvider>` untuk mendengarkan "teriakan" dari Provider.
- Jika Provider bilang "Sedang loading", UI menampilkan putaran loading.
- Jika Provider bilang "Ada data", UI menampilkan list user.

## Cara Menggunakan
1.  Buka aplikasi.
2.  Pilih menu "4. CRUD API (ReqRes.in)".
3.  Akan muncul daftar user yang diambil dari internet.
4.  Klik tombol (+) untuk menambah user (Simulasi saja, karena reqres.in tidak benar-benar menyimpan data selamanya).
5.  Klik icon pensil untuk edit.
6.  Klik icon sampah untuk hapus.

## Catatan Penting
Karena kita menggunakan API dummy (ReqRes.in), data yang kita tambah/edit/hapus **tidak akan tersimpan permanen di server ReqRes**. 
Namun, di aplikasi ini kita sudah membuat simulasi agar perubahan terlihat di layar HP kita seolah-olah berhasil tersimpan.
