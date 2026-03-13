import 'package:flutter/material.dart';
import 'counter_logic.dart';

class CounterPageBetterGetx extends StatefulWidget {
  const CounterPageBetterGetx({super.key});

  @override
  State<CounterPageBetterGetx> createState() => _CounterPageBetterGetxState();
}

class _CounterPageBetterGetxState extends State<CounterPageBetterGetx> {
  final CounterLogicGetx counterLogic = CounterLogicGetx();

  void increment() {
    setState(() {
      counterLogic.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GetX: Counter (BETTER Practice)'),
        backgroundColor: Colors.yellow[100],
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
