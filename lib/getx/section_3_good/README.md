# Dokumentasi GetX Section 3: Good Practice (GetxController)

Folder ini berisi fundamental penggunaan pola reaktif pada **GetX**. 

Bandingkan dengan Provider (yang membutuhkan class `notifyListeners` dan wrapper di `main.dart`). Di GetX:
1. Kita tidak diwajibkan melakukan instalasi MultiProvider root element di file _main.dart_ untuk menyimpan memori Global State. GetX menyimpan instansinya di memorinya sendiri.
2. Setiap kali var dengan tipe `.obs` dirubah (seperti `counter++`), otomatis merender bagian UI *Widget* yang dibungkus oleh `Obx()`.
3. Cukup menggunakan `Get.put(CounterControllerGetx())` untuk mendaftar sekaligus memanggil state.
