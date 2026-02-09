import 'package:flutter/material.dart';
import 'layout_page.dart';
import 'scaffold_page.dart';
import 'form_page.dart';
import 'media_list_page.dart';
import 'responsive_page.dart';
import 'navigation_page.dart';

class BasicWidgetsMenu extends StatelessWidget {
  const BasicWidgetsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Materi Widget Dasar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            context,
            '1. Layout & Dasar',
            'Container, Padding, Row, Column, Expanded',
            Icons.dashboard,
            const LayoutPage(),
          ),
          _buildMenuItem(
            context,
            '2. Scaffold Structure',
            'AppBar, Body, FAB, BottomNav',
            Icons.web_asset,
            const ScaffoldPage(),
          ),
          _buildMenuItem(
            context,
            '3. Input & Buttons',
            'TextField, Switch, Radio, Buttons',
            Icons.touch_app,
            const FormPage(),
          ),
          _buildMenuItem(
            context,
            '4. Media & List',
            'Image, Text Custom, ListView',
            Icons.image,
            const MediaListPage(),
          ),
          _buildMenuItem(
            context,
            '5. Responsive (Ukuran Layar)',
            'MediaQuery, LayoutBuilder',
            Icons.aspect_ratio,
            const ResponsivePage(),
          ),
          _buildMenuItem(
            context,
            '6. Navigation',
            'Navigator Push & Pop',
            Icons.directions,
            const NavigationPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Widget page,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 36),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}
