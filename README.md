# 📱 Materi Belajar Flutter

Aplikasi ini adalah modul dan repositori pembelajaran komprehensif untuk memahami fundamental pengembangan aplikasi menggunakan Flutter. Mulai dari penyusunan **UI Dasar**, penerapan **State Management**, hingga pemahaman **Arsitektur Aplikasi (MVC)** yang terintegrasi dengan REST API.

## 🚀 Daftar Materi & Fitur

Daftar modul pembelajaran dibagi menjadi dua kategori utama yang bisa diakses dari halaman utama aplikasi (Menu Page):

### 1. 🗂️ Materi Widget Dasar (`lib/basic_widgets`)
Kumpulan contoh dan latihan penggunaan widget fundamental di Flutter untuk menyusun antarmuka (UI):
- **Layouting:** Penggunaan `Row`, `Column`, `Stack`, dan penataan ruang lainnya.
- **Form & Input Validation:** Penanganan `TextField`, tombol submit, validasi form, dan sejenisnya.
- **Media:** Menampilkan gambar, ikon, dan manipulasi kontainer visual.
- **Navigation:** Teknik perpindahan antar halaman (routing).
- **Responsive UI:** Pengenalan desain antarmuka yang dapat beradaptasi dengan ukuran layar yang berbeda.

### 2. 🏗️ Materi State Management & Arsitektur (`lib/provider`)
Tahapan evolusi penulisan kode dan state management, mulai dari cara paling dasar hingga yang paling ideal untuk skala besar:

* **Section 1: BAD Practice (Logic di UI)**
  Menunjukkan bagaimana meletakkan Logika Bisnis (State) dan Tampilan (UI) di satu file yang sama menggunakan `setState` dapat menyebabkan kode sulit dibaca dan dipelihara.
* **Section 2: BETTER (Logic Terpisah)**
  Mulai mencoba memisahkan sebagian fungsi/logika ke tempat lain (class terpisah), tapi reaktivitas antar komponen UI masih secara manual.
* **Section 3: GOOD (Provider)**
  Penerapan state management **Provider**. Memisahkan UI dan Logika secara bersih. UI hanya bertugas menggambar komponen visual, dan Provider bertugas menangani logikanya.
* **Section 4: CRUD API (ReqRes.in)**
  Implementasi aksi HTTP lengkap (Create, Read, Update, Delete) yang diintegrasikan dengan fake public API dari [ReqRes.in](https://reqres.in/).
* **Section 5: MVC Pattern + API (http)**
  Refactoring secara total dengan menerapkan arsitektur **Model-View-Controller (MVC)** standard dan rapi menggunakan package bawaan `http`.
* **Section 6: MVC Pattern + Dio**
  Pendalaman struktur MVC yang digabungkan dengan HTTP Client **Dio**. Dio sangat tangguh untuk menghandle *interceptor*, *error handling*, manajemen Header API secara terpusat, dan berbagai kebutuhan *networking* tingkat lanjut.

## 📁 Struktur Direktori Utama

```text
lib/
├── basic_widgets/      # Modul 1: Latihan dan layouting widget dasar
├── config/             # Konfigurasi aplikasi (contoh: path/url endpoint)
├── provider/           # Modul 2: Materi State management & pola MVC
│   ├── section_1...    # dst.
│   ├── section_6_mvc_dio/
│   │   ├── controllers/# Business logic dan manipulasi state
│   │   ├── models/     # Kelas model / blueprint data (JSON serializer)
│   │   ├── services/   # Pengelolaan koneksi (Networking) API/DB
│   │   └── views/      # Antarmuka Pengguna/UI Screens
└── main.dart           # Entry point aplikasi & konfigurasi MultiProvider
```

## 🛠️ Cara Menjalankan Proyek

1. **Pastikan SDK Flutter sudah terinstall.**
2. Clone/Buka folder direktori proyek di IDE (VSCode / Android Studio / IntelliJ).
3. Unduh semua dependensi package dengan menjalankan:
   ```bash
   flutter pub get
   ```
4. Hubungkan emulator, simulator iOS, atau device fisik (atau browser untuk Web).
5. Run aplikasi menggunakan tombol **Play/Run** di IDE, atau ketikkan:
   ```bash
   flutter run
   ```

## 📦 Dependensi Utama Utama
- [`provider`](https://pub.dev/packages/provider): Tool yang paling direkomendasikan untuk manajemen UI State sederhana di Flutter.
- [`http`](https://pub.dev/packages/http): HTTP Client bawaan yang sangat simpel.
- [`dio`](https://pub.dev/packages/dio): HTTP Client andalan yang sering dipakai di aplikasi korporat/skala besar.

---
_Dibuat sebagai referensi panduan belajar untuk developer Flutter yang ingin mendalami best practice dalam coding!_
