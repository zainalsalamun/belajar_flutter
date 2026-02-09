import 'package:flutter/material.dart';

class MediaListPage extends StatelessWidget {
  const MediaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image, Font & ListView')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            '1. Image (Network)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Image widget
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://picsum.photos/400/200', // Placeholder image
              height: 150,
              width: 300,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  height: 150,
                  width: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 150,
                    width: 300,
                    color: Colors.grey,
                    child: const Icon(Icons.error),
                  ),
            ),
          ),

          const Divider(height: 20),

          const Text(
            '2. Custom TextStyle',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Ini adalah contoh text dengan Style custom. \n'
              'Untuk Custom Font, tambahkan file .ttf di folder assets/fonts '
              'dan daftarkan di pubspec.yaml.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Serif', // Fallback to system serif if not found
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.deepPurple,
                letterSpacing: 1.5,
              ),
            ),
          ),

          const Divider(height: 20),

          const Text(
            '3. ListView (Vertical)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Item List Nomor ${index + 1}'),
                  subtitle: const Text('Contoh subtitle list'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
