import 'package:flutter/material.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar saat ini
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Layout')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blueGrey[50],
            child: Text(
              'Screen Width: ${size.width.toStringAsFixed(2)}\n'
              'Screen Height: ${size.height.toStringAsFixed(2)}\n'
              'Mode: ${isSmallScreen ? "Mobile (Small)" : "Tablet/Desktop (Large)"}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'LayoutBuilder Example:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                // LayoutBuilder memberikan constraints dari parent widget
                if (constraints.maxWidth > 600) {
                  return _buildWideLayout();
                } else {
                  return _buildNarrowLayout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowLayout() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 200,
        width: 200,
        color: Colors.red,
        child: const Center(
          child: Text(
            'Mobile Layout\n(One Column)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            height: 200,
            width: 200,
            color: Colors.green,
            child: const Center(
              child: Text('Left Panel', style: TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            height: 200,
            width: 200,
            color: Colors.green,
            child: const Center(
              child: Text('Right Panel', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
