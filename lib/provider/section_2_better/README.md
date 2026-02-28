# Dokumentasi Section 2: Better Practice (Pemisahan Logic)

Folder ini berisi contoh implementasi yang **lebih baik** dibandingkan Section 1, yaitu dengan menerapkan prinsip **Separation of Concerns** (Pemisahan Tanggung Jawab) antara **UI** dan **Logic**.

## Struktur Kode

1.  **`counter_logic.dart`**: Berisi class murni Dart yang menangani logika bisnis (perhitungan).
2.  **`counter_page.dart`**: Berisi Widget UI yang menampilkan data dan menangani interaksi user.

### Perubahan Utama

Di section ini, kita memindahkan variabel dan fungsi manipulasi data ke dalam class `CounterLogic`:

```dart
// counter_logic.dart
class CounterLogic {
  int value = 0;

  void increment() {
    value++;
  }
}
```

Kemudian di UI, kita hanya perlu memanggil instance dari class tersebut:

```dart
// counter_page.dart
final CounterLogic counterLogic = CounterLogic();

void increment() {
  setState(() {
    counterLogic.increment(); // Panggil fungsi dari class logic
  });
}
```

## Apa Kelebihannya?

1.  **Separation of Concerns**: Logic tidak lagi "mengotori" file UI. Kode menjadi lebih rapi dan terorganisir.
2.  **Unit Testable**: Karena `CounterLogic` adalah class Dart murni (tidak butuh context Flutter), kita bisa membuat *Unit Test* dengan sangat mudah dan cepat untuk memastikan logic `increment` berjalan dengan benar.
3.  **Readability**: Developer lain bisa lebih cepat memahami cara kerja aplikasi dengan hanya melihat file logic, tanpa terganggu oleh kode styling UI.

## Mengapa Belum "Perfect"?

Meskipun sudah lebih baik, pendekatan ini masih memiliki kekurangan yang akan diperbaiki di section selanjutnya:

1.  **Manual `setState`**: UI masih harus memanggil `setState` secara eksplisit. Jika kita lupa memanggil `setState`, data di class logic akan berubah tapi tampilan tidak akan ter-update.
2.  **Tightly Coupled UI-Logic Update**: UI masih bertanggung jawab untuk mengetahui *kapan* data berubah. Idealnya, logic yang memberi tahu UI bahwa ada perubahan.
3.  **State Management Skala Besar**: Jika data ini perlu diakses oleh banyak halaman (misal: data profil di Header dan Settings), mengoper instance `counterLogic` antar widget akan menjadi sangat merepotkan (Prop Drilling).

Di **Section 3**, kita akan melihat bagaimana menggunakan **ChangeNotifier** untuk membuat logic bisa "memberi tahu" UI secara otomatis tanpa manual `setState`.
