# Dokumentasi GetX MVC Section 5: API dengan `http`

Pada bagian ini, kita memisahkan logika ke dalam arsitektur **MVC** layaknya pada provider.

- `services/user_service.dart`: Kode fetching mentah hanya ditempatkan di sini. Layanan ini mendelegasikan parsing JSON mandiri menggunakan standard dart `http`.
- `controllers/user_controller.dart`: Sebagai wadah state manager (`.obs`), _Controller_ tidak lagi berinteraksi langsung ke API, melainkan memerintahkan file di `.service`, lalu melempar (*throw*) hasilnya ke tampilan *Views*. Ini meningkatkan keterbacaan kode (Clean Code Architecture).
- `views/user_list_view.dart`: Area khusus menggambar interaktivitas UI (`Obx`). Tampilan ini 100% pasif (Hanya memanggil fungsi dari Object Controller tanpa pedulikan bagaimana cara HTTP terhubung).
