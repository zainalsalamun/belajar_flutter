# Dokumentasi Bloc Section 2: Better Practice (Pisah Logic)

Disini kita sudah mencoba memisahkan variable logic dan counter ke dalam kelas biasa (`counter_logic.dart`). Namun karena belum menggunakan Bloc pattern secara penuh, pembaruan ke layar UI masih harus ditulis berulang kali menggunakan fungsi pemicu `setState()`.