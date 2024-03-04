import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:foody_bloc_app/view/bottom_navigation/custom_bottom_navigation_screen.dart';

class CustomBottomNavigationBarPage extends StatelessWidget {
  const CustomBottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomNavigationBloc>(
      create: (context) => BottomNavigationBloc(),
      child: const CustomBottomNavigationBarScreen(),
    );
  }
}
