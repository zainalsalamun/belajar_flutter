import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'counter_controller.dart';

class CounterPageGoodGetx extends StatelessWidget {
  CounterPageGoodGetx({super.key});

  // Melakukan inisialisasi controller GetX
  final CounterControllerGetx controller = Get.put(CounterControllerGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX: Counter (GOOD Practice)'),
        backgroundColor: Colors.green[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GetXController + Obx()',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 20),
            // Obx digunakan untuk me-render spesifik widget ini ketika ada tipe .obs (observable) yang nilainya berubah
            Obx(
              () => Text(
                controller.counter.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.increment();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Tambah',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
