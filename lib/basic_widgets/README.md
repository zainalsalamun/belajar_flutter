# Dokumentasi Basic Widgets

Folder ini berisi kumpulan contoh implementasi widget-widget dasar pada Flutter. Setiap file merepresentasikan kategori widget tertentu untuk memudahkan pembelajaran.

## Daftar Materi

### 1. Layout & Dasar
**File:** `layout_page.dart`

Mendemonstrasikan cara menyusun tata letak (layout) widget.
- **Container**: Widget pembungkus serbaguna untuk memberikan padding, margin, warna background, border, dll.
- **Row**: Menyusun widget anak secara horizontal (ke samping).
- **Column**: Menyusun widget anak secara vertikal (ke bawah).
- **Expanded**: Widget yang memperluas anak widget untuk mengisi ruang kosong yang tersisa di dalam Row atau Column.
- **Flexible**: Mirip dengan Expanded, namun memungkinkan pengaturan proporsi ruang (flex) antar elemen.

### 2. Struktur Scaffold
**File:** `scaffold_page.dart`

Menjelaskan struktur dasar layout visual Material Design.
- **Scaffold**: Kerangka utama halaman yang menyediakan slot untuk AppBar, Body, FAB, dll.
- **AppBar**: Bar navigasi di bagian atas (mengandung judul, aksi).
- **Body**: Area utama tempat konten aplikasi ditampilkan.
- **FloatingActionButton (FAB)**: Tombol aksi utama yang melayang di atas konten.
- **BottomNavigationBar**: Bar navigasi di bagian bawah layar untuk berpindah antar tab utama.

### 3. Input & Buttons (Form)
**File:** `form_page.dart`

Contoh penggunaan widget interaktif untuk input pengguna.
- **Buttons**:
  - `ElevatedButton`: Tombol dengan background warna dan efek bayangan.
  - `TextButton`: Tombol teks tanpa border/background (biasanya untuk aksi sekunder).
  - `OutlinedButton`: Tombol dengan garis tepi (border).
  - `IconButton`: Tombol berupa ikon.
- **TextField**: Kotak input untuk menerima teks dari pengguna.
- **Switch**: Tombol geser on/off.
- **Checkbox**: Kotak centang untuk pilihan boolean.
- **Radio**: Pilihan eksklusif (hanya satu yang bisa dipilih dalam grup).
- **DropdownButton**: Menu pilihan yang bisa diklik untuk menampilkan daftar opsi.

### 4. Media & List
**File:** `media_list_page.dart`

Menampilkan media gambar dan daftar data yang panjang.
- **Image.network**: Menampilkan gambar yang diambil dari internet (URL). Dilengkapi dengan `loadingBuilder` dan `errorBuilder` untuk menangani proses loading dan error.
- **Text Custom**: Contoh styling teks (font family, size, color, style) menggunakan `TextStyle`.
- **ListView.builder**: Cara efisien menampilkan daftar item (list) yang datanya banyak atau dinamis. Hanya merender item yang terlihat di layar.

### 5. Responsive Layout
**File:** `responsive_page.dart`

Teknik membuat tampilan yang menyesuaikan ukuran layar (Mobile vs Tablet/Desktop).
- **MediaQuery**: Mengakses data media perangkat, seperti ukuran layar (`size.width`, `size.height`), orientasi, dll.
- **LayoutBuilder**: Widget yang memberikan informasi `constraints` dari parent-nya, memungkinkan kita membangun widget yang berbeda berdasarkan ketersediaan ruang (misal: jika lebar > 600px tampilkan 2 kolom).

### 6. Navigation
**File:** `navigation_page.dart`

Sistem perpindahan antar halaman (Routing).
- **Navigator.push**: Menambahkan halaman baru ke tumpukan navigasi (pindah ke halaman berikutnya).
- **Navigator.pop**: Menghapus halaman paling atas dari tumpukan (kembali ke halaman sebelumnya).

---

## Cara Menggunakan

Untuk melihat hasil dari setiap materi di atas, jalankan aplikasi dan buka menu **"Materi Widget Dasar"** dari halaman utama (jika sudah didaftarkan) atau panggil `BasicWidgetsMenu` sebagai home di `main.dart`.
