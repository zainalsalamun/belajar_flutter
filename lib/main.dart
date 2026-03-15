import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

// -- Provider Imports --
import 'provider/section_1_bad/counter_page.dart';
import 'provider/section_2_better/counter_page.dart';
import 'provider/section_3_good/counter_page.dart';
import 'provider/section_3_good/counter_provider.dart';
import 'provider/section_4_crud_api/user_provider.dart';
import 'provider/section_4_crud_api/user_list_page.dart';
import 'provider/section_5_mvc_api/controllers/user_controller.dart';
import 'provider/section_5_mvc_api/views/user_list_view.dart';
import 'provider/section_6_mvc_dio/controllers/user_controller.dart';
import 'provider/section_6_mvc_dio/views/user_list_view.dart';

// -- GetX Imports --
import 'getx/section_1_bad/counter_page.dart';
import 'getx/section_2_better/counter_page.dart';
import 'getx/section_3_good/counter_page.dart';
import 'getx/section_4_crud_api/user_list_page.dart';
import 'getx/section_5_mvc_api/views/user_list_view.dart';
import 'getx/section_6_mvc_dio/views/user_list_view.dart';

import 'basic_widgets/basic_widgets_menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => UserDioController()),
      ],
      // Ganti MaterialApp jadi GetMaterialApp utk support fitur route, snackbar GetX
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Materi Belajar Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Belajar Flutter')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Materi Widget Dasar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                '📂 Basic Widgets Examples',
                Colors.blue[100]!,
                const BasicWidgetsMenu(),
              ),

              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const SizedBox(height: 20),

              const Text(
                'Materi State Management (Provider)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'P-1. BAD Practice',
                Colors.red[100]!,
                const CounterPageBad(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'P-2. BETTER (Logic Pisah)',
                Colors.orange[100]!,
                const CounterPageBetter(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'P-3. GOOD (Provider)',
                Colors.green[100]!,
                const CounterPageGood(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'P-4. CRUD API (ReqRes)',
                Colors.purple[100]!,
                const UserListPage(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'P-5. MVC Pattern + API',
                Colors.teal[100]!,
                const UserListView(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'P-6. MVC Pattern + Dio',
                Colors.indigo[100]!,
                const UserListDioView(),
              ),

              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const SizedBox(height: 20),

              const Text(
                'Materi State Management (GetX)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildGetXMenuButton(
                'G-1. BAD Practice',
                Colors.red[100]!,
                const CounterPageBadGetx(),
              ),
              const SizedBox(height: 10),
              _buildGetXMenuButton(
                'G-2. BETTER (Logic Pisah)',
                Colors.orange[100]!,
                const CounterPageBetterGetx(),
              ),
              const SizedBox(height: 10),
              _buildGetXMenuButton(
                'G-3. GOOD (GetX + Obx)',
                Colors.green[100]!,
                CounterPageGoodGetx(),
              ),
              const SizedBox(height: 10),
              _buildGetXMenuButton(
                'G-4. CRUD API (ReqRes)',
                Colors.purple[100]!,
                UserListPageGetx(),
              ),
              const SizedBox(height: 10),
              _buildGetXMenuButton(
                'G-5. MVC Pattern + API',
                Colors.teal[100]!,
                UserMvcApiGetxListView(),
              ),
              const SizedBox(height: 10),
              _buildGetXMenuButton(
                'G-6. MVC Pattern + Dio',
                Colors.indigo[100]!,
                UserMvcDioGetxListView(),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Tombol navigasi standar
  Widget _buildMenuButton(
    BuildContext context,
    String title,
    Color color,
    Widget page,
  ) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title, style: const TextStyle(color: Colors.black)),
      ),
    );
  }

  // Tombol navigasi rute GetX
  Widget _buildGetXMenuButton(String title, Color color, Widget page) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: () {
          Get.to(() => page); // Jauh lebih pendek navigasinya!
        },
        child: Text(title, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
