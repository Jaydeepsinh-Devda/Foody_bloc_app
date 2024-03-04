import 'package:flutter/material.dart';
import 'package:foody_bloc_app/view/bottom_navigation/screen/custom_bottom_navigation_page.dart';
import 'package:foody_bloc_app/view/home/home_page.dart';
import 'package:foody_bloc_app/view/home/home_screen.dart';
import 'package:foody_bloc_app/view/login/login_page.dart';
import 'package:foody_bloc_app/view/login/login_screen.dart';

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
        LoginScreen.tag: (context) => const LoginPage(),
        HomeScreen.tag: (context) => const HomePage()
      },
    );
  }
}
