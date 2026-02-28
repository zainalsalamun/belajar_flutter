# Dokumentasi Section 5: MVC Pattern + API (`http`)

Folder ini merupakan peningkatan signifikan dari cara penulisan kode di `section_4`. Kita mulai menerapkan pola arsitektur **Model-View-Controller (MVC)** untuk memisahkan logika secara lebih tegas. Tujuannya adalah membuat "Clean Architecture" yang mudah dites, dirawat (*maintainable*), dan diperbesar skalanya.

## Perbedaan Utama dengan Section 4

Di modul sebelumnya (Section 4), **Provider** bertindak ganda sebagai pengelola *state* (indikator mutasi UI) sekaligus sebagai eksekutor *HTTP request* (networking).
Di Section 5 ini, urusan *networking* sepenuhnya diekstrak dan dipindahkan ke lapisan baru yang disebut **Service**. 

Berikut adalah pembagian peran di pola MVC ini:

## Struktur Folder & Pembagian Peran (MVC)

### 1. Model (`models/user_model.dart`)
Berisi **Data Blueprint** (Cetak biru objek).
- Bertanggung jawab memetakan struktur data `User`.
- Menyediakan metode *serialization/deserialization* dari format JSON mentah API menjadi tipe data *Object* di Dart (`User.fromJson()`).
- Sama netralnya, **tidak boleh** memuat logika bisnis maupun koneksi API.

### 2. Service (`services/user_service.dart`)
Lapisan baru untuk **Logika Koneksi (Networking)**.
- Menjalankan murni *HTTP Request* (GET, POST, PUT, DELETE) menggunakan package `http`.
- Menangani konfigurasi Header (`x-api-key`, `Content-Type`), parsing JSON, dan pengecekan kode status respons (`statusCode == 200`).
- Jika berhasil, ia mengembalikan daftar/objek Model. Jika gagal, ia akan *lempar* atau *throw Error/Exception*.
- **Penting:** Service **tidak memiliki dan tidak menyimpan State global**. Data yang diambil hanya sekedar lewat untuk dilempar kembali (return value).

### 3. Controller (`controllers/user_controller.dart`)
Lapisan yang menjadi jembatan antara **View** dan **Service** sekaligus sebagai **State Management (Provider)**.
- Mendeklarasikan dan mengelola *Global State* seperti pendaftaran memori data (`_users`), indikator antrean (`_isLoading`), dan laporan kegagalan (`_error`).
- Memanggil fungsi dari dalam `UserService`. Misalnya: saat UI membutuhkan data, Controller akan memanggil `UserService.fetchUsers()`.
- Jika `UserService` berhasil me-return data, Controller ini akan menyimpannya ke memori, lalu memanggil `notifyListeners()` agar UI segera ter-update.
- Manfaat: Kode jauh lebih sinkron. Jika endpoint/link API berubah, Anda hanya mengedit file perantara (Service), tidak perlu bongkar-bongkar variabel memori UI di dalam Controller.

### 4. View (`views/`)
Lapisan tampilan **Antarmuka Pengguna/UI Screens**.
- `user_list_view.dart`: Menampilkan desain daftar tabel dari memori `UserController`.
- `user_form_view.dart`: Formulir visual untuk proses *Create* dan *Update*.
- **Penting:** View hanya "Mendengarkan" (menggunakan *watcher/consumer*) dan memberikan perintah (menggunakan *reader/trigger*) ke **Controller**. View sama sekali **TIDAK BOLEH** mengeksekusi request HTTP atau mendefinisikan *business logic* rumit apa pun secara mandiri!

## Bagaimana Alur Kerjanya (Flow)?

1. **TRIGGER**: Pengguna membuka halaman "View" dan memicu event (misalnya `initState` atau klik tombol). **View** memerintahkan aksi `fetchUsers()` ke **Controller**.
2. **LOADING**: **Controller** mengubah `_isLoading` menjadi `true`, lalu berteriak `notifyListeners()`. **View** merender animasi putaran memuat.
3. **PROCESS**: **Controller** melempar tugas ke **Service**. **Service** pergi mengambil request ke internet (ReqRes.in).
4. **RESOLUTION**: Jika berhasil, **Service** mengembalikan struktur data ke **Controller**. **Controller** menyimpan datanya di list `_users`, mengubah status `_isLoading` menjadi `false`, dan memanggil `notifyListeners()` untuk kedua kalinya.
5. **RENDER**: **View** mendengarnya, mematikan putaran loading baris per-baris, dan mulai menggambar list pengguna yang baru diekstrak.

## Kelebihan Pattern MVC Ini

1. **High Cohesion, Low Coupling (Terstruktur)**: Modul-modul bisa eksis secara independen. Jika desain aplikasi total diubah 100%, cukup ubah folder `views/`, folder lain tidak akan disentuh/terganggu.
2. **Unit Testing yang Mudah**: Developer dapat melakukan pengujian skrip otomatis hanya pada bagian `user_controller`, tanpa perlu menjankan *emulator design UI* di layar sama sekali, karena fungsinya telah terpotong jelas!
3. **Reusable Engine**: Satu file `UserService` dapat dipanggil tidak di satu controller saja, namun bisa digunakan ulang oleh modul lain yang sekiranya masih membutuhkan URL dan parameter API yang sama persis.
