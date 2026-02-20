# Dokumentasi Section 1: Bad Practice (Logic di UI)

Folder ini berisi contoh implementasi state management yang dianggap **kurang ideal** untuk aplikasi skala menengah hingga besar, yaitu dengan mencampurkan **Logic** langsung di dalam **UI** menggunakan `setState`.

## Struktur Kode
**File:** `counter_page.dart`

Pada contoh ini, logika bisnis (ubah nilai counter) dan tampilan (UI) berada dalam satu file yang sama:

```dart
class _CounterPageBadState extends State<CounterPageBad> {
  int counter = 0; // State (Data) langsung di UI

  // Logic (Fungsi) langsung di UI
  void increment() {
    setState(() {
      counter++;
    });
  }
...
```

## Mengapa ini disebut "Bad Practice"?

Meskipun `setState` adalah cara yang benar dan resmi untuk mengelola state lokal (ephemeral state) pada widget sederhana, pendekatan ini memiliki beberapa kelemahan jika digunakan untuk **logika bisnis** aplikasi yang kompleks:

1.  **Tightly Coupled (Terikat Erat)**:
    Logika bisnis dan UI bercampur menjadi satu. Jika UI berubah, logic bisa ikut terdampak, dan sebaliknya. Kode menjadi sulit dibaca dan dirawat seiring bertambahnya fitur.

2.  **Susah di-Test (Unit Testing)**:
    Karena logic berada di dalam Widget, kita tidak bisa melakukan *Unit Test* hanya pada logic-nya saja. Kita harus melakukan *Widget Test* yang lebih lambat dan kompleks.

3.  **Susah Reusability (Digunakan Kembali)**:
    Logic `increment` tidak bisa dengan mudah digunakan oleh widget lain di halaman berbeda karena logic tersebut "terkunci" di dalam `_CounterPageBadState`.

4.  **Performance Issue (Potensial)**:
    Pemanggilan `setState` akan memicu method `build()` untuk dijalankan ulang. Jika widget tree di dalamnya sangat kompleks, melakukan rebuild seluruh halaman hanya untuk update satu angka kecil adalah pemborosan resource.

## Kapan Boleh Menggunakan `setState`?

Gunakan `setState` hanya untuk **Ephemeral State** (state sementara UI), seperti:
- Status animasi (start/stop).
- Status tab aktif di halaman itu saja.
- Status loading tombol lokal.
- Scroll position.

Untuk **App State** (data user, keranjang belanja, authentication) atau Business Logic yang kompleks, sebaiknya pisahkan logic dari UI (seperti yang akan dibahas di section selanjutnya).
