# Dokumentasi Riverpod MVC Section 6: Architecture + Dio

Di dalam Riverpod, mencampur arsitektur modular pattern MVC dengan package `Dio` bisa dianalogikan sebagai "Mode Super". 

Mengapa?
1. Controller (StateNotifier/Notifier) memisahkan logic dengan UI tanpa framework lock-in seperti GetX.
2. Tidak ada MultiProvider yang bersarang dalam UI, hanya `ProviderScope` di App root.
3. Menawarkan tipe yang lebih kuat (Type-safe) dan mudah di-test.
4. Exception dari server langsung tertangani lewat DioInterceptor (`_handleError` di Service layer).
5. Otomatisasi konversi (*Auto parse JSON*) Dio membuat Service class jauh lebih singkat dari HTTP standar.

Modul ini adalah contoh komprehensif menggunakan **Riverpod** sebagai pengganti GetX/Provider standar untuk mengelola _Frontend_ aplikasi bisnis skala menengah/besar.
