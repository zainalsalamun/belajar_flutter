# Dokumentasi Section 3: Good Practice (Provider)

Folder ini berisi contoh implementasi state management yang disarankan untuk pengembangan aplikasi Flutter, yaitu menggunakan package **Provider** (dengan perpaduan algoritma `ChangeNotifier`). Arsitektur ini adalah titik awal yang ideal untuk membuat aplikasi yang bersih (clean code) karena memisahkan Tampilan (UI) dari Logika Bisnis.

## Struktur Kode

### 1. File: `counter_provider.dart` (Logika & State)
File ini bertanggung jawab **murni** terhadap logika dan manipulasi data. File ini tidak memiliki referensi apa pun ke antarmuka pengguna (Widget).

```dart
class CounterProvider extends ChangeNotifier {
  int _counter = 0; // State disembunyikan (private)

  int get counter => _counter; // Getter untuk mengambil data

  void increment() {
    _counter++;
    notifyListeners(); // KUNCI: Memberitahu UI untuk me-render ulang saat state berubah
  }
}
```
- **`ChangeNotifier`**: Class bawaan Flutter SDK yang memungkinkan kita membuat objek yang dapat didengarkan (observable).
- **`notifyListeners()`**: Metode yang sangat penting. Saat ini dipanggil, ia akan "berteriak" ke seluruh UI yang sedang mengamati (mendengarkan) state bahwa ada data yang berubah, sehingga UI harus segera di-rebuild.

### 2. File: `counter_page.dart` (Antarmuka/UI)
File ini menggunakan `StatelessWidget`. UI tidak lagi menyimpan *state* internal aplikasi seperti variabel `counter`, sehingga peran pembuatan interaksi murni dikontrol dari file Provider.

```dart
class CounterPageGood extends StatelessWidget {
...
  @override
  Widget build(BuildContext context) {
    // 1. Mendengarkan secara terus-menerus state dari Provider
    final counterProvider = context.watch<CounterProvider>();

    return Scaffold(
...
        // 2. Tampilkan State dari provider
        Text(counterProvider.counter.toString()), 

        ElevatedButton(
          onPressed: () {
            // 3. Panggil aksi/logic melalui read (hanya baca satu kali tanpa mendengarkan perubahannya kembali)
            context.read<CounterProvider>().increment();
          },
...
```

## Keunggulan (Mengapa ini disebut "Good Practice"?)

1. **Separation of Concerns (Pemisahan Tugas Bersih)**
   Kode menjadi jauh lebih rapi. UI fokus pada urusan visual (`build` function), sementara Provider menangani hitungan asinkron/sinkron. Jika design berubah, kita hanya memanipulasi file UI. Jika rumus aplikasi berubah, kita hanya membuka file Provider.

2. **Performa Rebuild yang Lebih Baik**
   Jika dimanfaatkan bersama widget `Consumer` atau dipecah menjadi widget kecil dengan `watch`, UI yang mendengarkan `notifyListeners()` hanya komponen spesifik saja (yang berhubungan langsung dengan state), sehingga mencegah *rebuild* seluruh halaman yang sia-sia, berbeda jauh dengan memanggil `setState()` global.

3. **Reusability**
   Data/Objek Provider dapat diakses dan digunakan di halaman atau widget mana pun yang menjadi "keturunan" dari provider utamanya yang didefinisikan dalam `main.dart` tanpa perlu melempar-lempar parameter state (props drilling).

4. **Sangat Mudah di-Test**
   Kita bisa memanggil instance function `increment()` dari modul unit tests untuk memverifikasi fungsionalitas murni secara instan, tanpa merender halaman dari sisi UI sama sekali (`WidgetTesting`). 

## Cara Kerja
1. Di `main.dart`, Provider didaftarkan ke seluruh hirarki aplikasi via `ChangeNotifierProvider`.
2. Halaman memicu `context.read<CounterProvider>().increment()`.
3. state `_counter` dalam Provider berubah, lalu mengeksekusi `notifyListeners()`.
4. Halaman yang melakukan `context.watch` menyadari panggilan dari listener ini dan merender ulang teks ke layar (menampilkan angka baru).
