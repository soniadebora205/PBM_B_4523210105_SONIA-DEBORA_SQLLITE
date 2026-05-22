import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseHelper.instance.database;
  await DatabaseHelper.instance.createTables(db);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manajemen Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF009688)),
        useMaterial3: true,
        textTheme: GoogleFonts.loraTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}