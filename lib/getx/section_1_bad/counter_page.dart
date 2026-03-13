import 'package:flutter/material.dart';

class CounterPageBadGetx extends StatefulWidget {
  const CounterPageBadGetx({super.key});

  @override
  State<CounterPageBadGetx> createState() => _CounterPageBadGetxState();
}

class _CounterPageBadGetxState extends State<CounterPageBadGetx> {
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
        title: const Text('GetX: Counter (BAD Practice)'),
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
