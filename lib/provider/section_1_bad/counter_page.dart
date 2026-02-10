import 'package:flutter/material.dart';

class CounterPageBad extends StatefulWidget {
  const CounterPageBad({super.key});

  @override
  State<CounterPageBad> createState() => _CounterPageBadState();
}

class _CounterPageBadState extends State<CounterPageBad> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter (BAD Practice)'),
        backgroundColor: Colors.red[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logic & UI Campur (setState)',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text(
              counter.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: increment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
