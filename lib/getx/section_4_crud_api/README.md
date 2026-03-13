# Dokumentasi GetX Section 4: CRUD API (ReqRes.in)

Sama dengan provider, folder ini mengintegrasikan interaktivitas state GetX dan aksi jaringan HTTP secara simultan ke `ReqRes.in`.

### Menyoroti Perbedaan GetX dan Provider:
1. **Navigasi instan (`Get.to()`, `Get.back()`, `Get.snackbar()`)**:
   - Jika di provider kita harus mengirim "Context" ke mana-mana: `Navigator.push(context,...)`, `ScaffoldMessenger.of(context).showSnackbar`. Pusing, kan?
   - GetX menyelesaikan masalah ini! Lihat bagaimana fungsi CRUD memberikan umpan balik (Snackbar/Notifikasi bawaan iOS/Android) yang sangat halus, *semuanya tanpa melempar BuildContext* dari antarmuka!
2. **Reaktivitas `Rx` & `Obx`**:
   - Saat state model berubah, re-render tampilan otomatis langsung tercermin. `user[index] = updatedUser` memicu UI List membarui spesifik row index-nya (berkat `.obs`).
   - Tidak lagi repot dengan `notifyListeners`.
3. **onInit Lifecycle**:
   - Controller GetX memiliki tahapan render (*lifecycle*) mandiri layaknya Stateful Widget. Karenanya fetching API (`fetchUsers()`) cukup digeret di fungsi override `onInit`, bukan disematkan ke antarmuka klien menggunakan `addPostFrameCallback` seperti pada mode Provider. Sangat rapi!
