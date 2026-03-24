import 'package:flutter/material.dart';
import 'counter_logic.dart';

class CounterPageBetterRiverpod extends StatefulWidget {
  const CounterPageBetterRiverpod({super.key});

  @override
  State<CounterPageBetterRiverpod> createState() => _CounterPageBetterRiverpodState();
}

class _CounterPageBetterRiverpodState extends State<CounterPageBetterRiverpod> {
  final CounterLogicRiverpod logic = CounterLogicRiverpod();

  void increment() {
    setState(() {
      logic.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod: Counter (BETTER)'),
        backgroundColor: Colors.orange[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logic Pisah, Tapi Manual setState',
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
            const SizedBox(height: 20),
            Text(
              logic.value.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: increment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Tambah', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
