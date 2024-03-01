import 'package:flutter/material.dart';
import 'package:foody_bloc_app/view/bottom_navigation/screen/custom_bottom_navigation_page.dart';
import 'package:foody_bloc_app/view/home/screen/home_page.dart';
import 'package:foody_bloc_app/view/login/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CustomBottomNavigationBarPage(),
      routes: {
        LoginScreen.tag: (context) => const HomePage(),
      },
    );
  }
}
