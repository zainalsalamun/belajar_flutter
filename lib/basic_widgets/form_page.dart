import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  // State variables for inputs
  bool _isSwitched = false;
  String _selectedValue = 'Option 1';
  bool _isChecked = false;
  String _dropdownValue = 'One';
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input & Buttons (Stateful)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Buttons',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Elevated')),
                TextButton(onPressed: () {}, child: const Text('Text Button')),
                OutlinedButton(onPressed: () {}, child: const Text('Outlined')),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up),
                  tooltip: 'Icon Button',
                ),
              ],
            ),

            const Divider(height: 30),

            const Text(
              '2. TextField',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: 'Masukkan Nama',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const Divider(height: 30),

            const Text(
              '3. Selection Controls',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            // Switch
            SwitchListTile(
              title: const Text('Switch Enable'),
              value: _isSwitched,
              onChanged: (bool value) {
                setState(() {
                  _isSwitched = value;
                });
              },
            ),
            // Checkbox
            CheckboxListTile(
              title: const Text('Checkbox Agree'),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
            ),
            // Radio
            Row(
              children: [
                const Text('Radio: '),
                Radio<String>(
                  value: 'Option 1',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() => _selectedValue = value!);
                  },
                ),
                const Text('A'),
                Radio<String>(
                  value: 'Option 2',
                  groupValue: _selectedValue,
                  onChanged: (String? value) {
                    setState(() => _selectedValue = value!);
                  },
                ),
                const Text('B'),
              ],
            ),

            const Divider(height: 30),

            const Text(
              '4. Dropdown',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            DropdownButton<String>(
              value: _dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              items:
                  <String>[
                    'One',
                    'Two',
                    'Three',
                    'Four',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
