import 'package:flutter/material.dart';
import 'counter_logic.dart';

class CounterPageBetter extends StatefulWidget {
  const CounterPageBetter({super.key});

  @override
  State<CounterPageBetter> createState() => _CounterPageBetterState();
}

class _CounterPageBetterState extends State<CounterPageBetter> {
  // Logic dipisah ke class lain
  final CounterLogic counterLogic = CounterLogic();

  void increment() {
    // Masih perlu setState manual di UI
    setState(() {
      counterLogic.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter (BETTER Practice)'),
        backgroundColor: Colors.yellow[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logic Pisah, Tapi Masih Manual setState',
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
            const SizedBox(height: 20),
            Text(
              counterLogic.value.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: increment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
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
