import 'package:flutter/material.dart';
import 'counter_logic.dart';

class CounterPageBetterBloc extends StatefulWidget {
  const CounterPageBetterBloc({super.key});

  @override
  State<CounterPageBetterBloc> createState() => _CounterPageBetterBlocState();
}

class _CounterPageBetterBlocState extends State<CounterPageBetterBloc> {
  final CounterLogicBloc counterLogic = CounterLogicBloc();

  void increment() {
    setState(() {
      counterLogic.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc: Counter (BETTER Practice)'),
        backgroundColor: Colors.blue[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Logic Pisah, Tapi Manual setState',
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text(
              counterLogic.value.toString(),
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
