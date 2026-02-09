import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout & Container')),
      body: Column(
        children: [
          // Section 1: Container & Padding & Center
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: const Center(
              child: Text(
                'Container + Padding + Center',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const Divider(),

          // Section 2: Row
          Container(
            height: 100,
            color: Colors.amber[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                  child: const Center(child: Text('Row 1')),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                  child: const Center(child: Text('Row 2')),
                ),
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.blue,
                  child: const Center(child: Text('Row 3')),
                ),
              ],
            ),
          ),

          const Divider(),

          // Section 3: Column (Nested in parent Column) already happening
          const Text(
            'Column items below:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            width: 100,
            height: 30,
            color: Colors.purple[100],
            child: const Center(child: Text('Col 1')),
          ),
          const SizedBox(height: 5),
          Container(
            width: 100,
            height: 30,
            color: Colors.purple[200],
            child: const Center(child: Text('Col 2')),
          ),

          const Divider(),

          // Section 4: Flexible & Expanded
          SizedBox(
            height: 100,
            child: Row(
              children: [
                Container(
                  width: 50,
                  color: Colors.grey,
                  child: const Center(child: Text('Fixed')),
                ),
                Expanded(
                  child: Container(
                    color: Colors.teal,
                    child: const Center(child: Text('Expanded (Sisa Ruang)')),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: Colors.indigo,
                    child: const Center(child: Text('Flexible')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
