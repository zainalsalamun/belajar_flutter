import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc_counter_page.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/section_1_bad/counter_page.dart' as bloc_section_1;
import 'bloc/section_2_better/counter_page.dart' as bloc_section_2;
import 'bloc/section_3_good/counter_page.dart' as bloc_section_3;
import 'bloc/section_4_crud_api/user_list_page.dart' as bloc_section_4;
import 'bloc/section_4_crud_api/user_bloc.dart' as bloc_section_4;
import 'bloc/section_5_mvc_api/blocs/user_bloc.dart' as bloc_section_5;
import 'bloc/section_5_mvc_api/views/user_list_view.dart' as bloc_section_5;
import 'bloc/section_6_mvc_dio/controllers/user_controller.dart'
    as bloc_section_6_controller;
import 'bloc/section_6_mvc_dio/views/user_list_view.dart' as bloc_section_6;
import 'bloc/section_7_mvvm/viewmodels/user_viewmodel.dart'
    as bloc_section_7_viewmodel;
import 'bloc/section_7_mvvm/views/user_list_view.dart' as bloc_section_7;
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

// -- Riverpod Imports --
import 'riverpod/section_1_bad/counter_page.dart';
import 'riverpod/section_2_better/counter_page.dart';
import 'riverpod/section_3_good/counter_page.dart';
import 'riverpod/section_4_crud_api/user_list_page.dart';
import 'riverpod/section_5_mvc_api/views/user_list_view.dart';
import 'riverpod/section_6_mvc_dio/views/user_list_view.dart';
import 'riverpod/section_7_mvvm/views/user_list_view.dart';
import 'riverpod/section_8_mvvm_freezed/views/user_list_view.dart';

import 'basic_widgets/basic_widgets_menu.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => UserController()),
          ChangeNotifierProvider(create: (_) => UserDioController()),
          BlocProvider(create: (_) => CounterBloc()),
          BlocProvider(create: (_) => bloc_section_4.UserBloc()),
          BlocProvider(create: (_) => bloc_section_5.UserBloc()),
          BlocProvider(
            create: (_) => bloc_section_6_controller.UserDioController(),
          ),
          BlocProvider(create: (_) => bloc_section_7_viewmodel.UserViewModel()),
        ],
        child: const MyApp(),
      ),
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

              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const SizedBox(height: 20),

              const Text(
                'Materi State Management (Riverpod)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-1. BAD Practice',
                Colors.red[100]!,
                const CounterPageBadRiverpod(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-2. BETTER (Logic Pisah)',
                Colors.orange[100]!,
                const CounterPageBetterRiverpod(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-3. GOOD (Notifier)',
                Colors.green[100]!,
                const CounterPageGoodRiverpod(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-4. CRUD API (ReqRes)',
                Colors.purple[100]!,
                const UserListPageRiverpod(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-5. MVC Pattern + API',
                Colors.teal[100]!,
                const UserMvcApiRiverpodListView(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-6. MVC Pattern + Dio',
                Colors.indigo[200]!,
                const UserMvcDioRiverpodListView(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'R-7. MVVM Clean + Dio',
                Colors.blue[300]!,
                const UserMvvmRiverpodListView(),
              ),
              const SizedBox(height: 30),
              const Divider(thickness: 2),
              const SizedBox(height: 20),

              const Text(
                'Materi State Management (Bloc)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-1. BAD Practice',
                Colors.red[100]!,
                bloc_section_1.CounterPageBadBloc(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-2. BETTER (Logic Pisah)',
                Colors.orange[100]!,
                bloc_section_2.CounterPageBetterBloc(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-3. GOOD (BLoC)',
                Colors.green[100]!,
                bloc_section_3.CounterPageGoodBloc(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-4. CRUD API (ReqRes)',
                Colors.purple[100]!,
                bloc_section_4.UserListPageBloc(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-5. MVC Pattern + API',
                Colors.teal[100]!,
                bloc_section_5.UserListView(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-6. MVC Pattern + Dio',
                Colors.indigo[100]!,
                bloc_section_6.UserListDioView(),
              ),
              const SizedBox(height: 10),
              _buildMenuButton(
                context,
                'B-7. MVVM Clean + Dio',
                Colors.blue[300]!,
                bloc_section_7.UserListView(),
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
