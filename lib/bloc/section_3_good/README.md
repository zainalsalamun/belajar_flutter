# Dokumentasi Bloc Section 3: Good Practice (Bloc Pattern)

Folder ini berisi fundamental penggunaan pola reaktif pada **Bloc (Business Logic Component)**. 

Di Bloc, kita memisahkan business logic sepenuhnya dari UI dengan pola event-state:
1. Kita perlu menyediakan Bloc menggunakan `BlocProvider` untuk mengelola lifecycle dan dependency injection
2. Setiap kali event ditambahkan (seperti `CounterEvent.increment`), Bloc akan memprosesnya dan mengeluarkan state baru
3. Widget yang membungkus state menggunakan `BlocBuilder` akan secara otomatis ter-render ulang ketika state baru diterima
4. Pattern ini memudahkan testing, maintainability, dan skalabilitas aplikasi