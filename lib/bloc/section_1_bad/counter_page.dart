import 'package:flutter/material.dart';

class CounterPageBadBloc extends StatefulWidget {
  const CounterPageBadBloc({super.key});

  @override
  State<CounterPageBadBloc> createState() => _CounterPageBadBlocState();
}

class _CounterPageBadBlocState extends State<CounterPageBadBloc> {
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
        title: const Text('Bloc: Counter (BAD Practice)'),
        backgroundColor: Colors.blue[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logic & UI Campur (setState)',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              counter.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: increment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
