# Dokumentasi Section 6: MVC Pattern + Dio (Advanced HTTP Client)

Folder ini adalah titik pengembangan tingkat lanjut (Advanced) dari pola MVC yang sudah dipelajari di section 5. Perbedaannya terletak pada *library* atau kurir jaringan yang diandalkan: kita mengganti HTTP Client bawaan (`http`) menjadi paket unggulan pihak ketiga bernama **[Dio](https://pub.dev/packages/dio)**.

Dio adalah salah satu *package networking* yang paling diandalkan dan paling banyak digunakan di level korporat atau aplikasi dengan skala besar dan kompleks berkat fiturnya yang sangat lengkap.

## Mengapa Memilih Dio? (Studi Kasus `UserService`)

Bila dilihat pada file `services/user_service.dart`, penggunaan Dio menawarkan banyak sekali pemangkasan *boilerplate* (kode berulang) serta keuntungan di bawah ini:

### 1. Global Configuration (BaseOptions)
Tidak perlu lagi mengetik `Uri.parse(baseUrl + endpoint)` dan melempar parameter *Header Content-Type* di setiap operasi CRUD. Dengan Dio, kita bisa mengkonfigurasi `BaseOptions` sekali saja tepat saat class diinisiasi:
```dart
  _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl, // Base url sudah paten
      connectTimeout: const Duration(seconds: 10), // Limit waktu koneksi putus
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': ApiConstants.apiKey, // Header tersematkan secara global otomatis
      },
    ),
  );
```
Sekarang, jika ingin melakukan fetch GET, kodenya cukup pendek menjadi: `await _dio.get('/users')`.

### 2. Auto-Parsing JSON response
Pada library `http`, kita harus membaca isi teks respons lalu menguraikannya menjadi objek Dart menggunakan cara manual `json.decode(response.body)`. Di Dio, respons tersebut **sudah berbentuk** `Map/List` otomatis di dalam properti `response.data`.

### 3. Log interceptor (Debugging)
Salah satu fitur *"Super Power"* Dio adalah kemampuannya menanamkan *Interceptor*, yang bisa disisipkan untuk mencegat alur pengiriman data sebelum jalan/sesudah pulang.
Pada file service di section ini, kita memanfaatkan `LogInterceptor`:
```dart
_dio.interceptors.add(
  LogInterceptor(
    requestBody: true,
    responseBody: true,
  ),
);
```
Dengan ini, saat kita menjalankan aplikasi dan menekan tombol di UI, konsol Terminal langsung mengeluarkan jejak log yang merinci URL mana yang diakses, apa status HTTP kodenya, dan apa persisnya isi payload datanya. 

### 4. Error Handling yang Kuat (DioException)
Dio membungkus seluruh status gagal komprehensif ke dalam tipe error khusus bernama `DioException`. Di akhir file service, fungsi `_handleError` menggunakan klasifikasi tipe error `e.type` untuk mengetahui secara spesifik apakah server merespon dengan TimeOut, No Internet, Cancel, atau sekedar Bad Response (400-500 status code). 

Ini membuat *Feedback Message* kepada pengguna (View) menjadi lebih relevan dan *Human-Friendly*.

## Flow Penggunaan
Alur interaktivitas atau **Flow MVC** (Model -> Service -> Controller -> View) di modul section 6 ini **sama persis** dengan arsitektur pada Section 5, membuktikan betapa serbagunanya pemisahan tugas (*Decoupling*). Modul Controller sama sekali tidak peduli bahwa *Service*-nya diubah dari library `http` menjadi `dio`, selama struktur return-value datanya konsisten.

## Cara Menggunakan Simulasi Ini
1. Pastikan Anda masuk ke modul via tombol aplikasi "6. MVC Pattern + Dio".
2. Bukalah konsol Terminal di editor Anda (seperti Run/Debug console di tab Android Studio atau Output *debug console* di VSCode).
3. Cobalah pencet tombol (+) untuk menambah pengguna atau tekan ikon tong sampah untuk mulai menghapus.
4. Anda akan melihat log yang sangat detil dari jaringan *ReqRes API* tercetak di layar berkat injeksi *Interceptors*.
