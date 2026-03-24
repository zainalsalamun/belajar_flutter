import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'counter_provider.dart';

class CounterPageGoodRiverpod extends ConsumerWidget {
  const CounterPageGoodRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod: Counter (GOOD)'),
        backgroundColor: Colors.green[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'NotifierProvider + ref.watch',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              counter.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Tambah', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
