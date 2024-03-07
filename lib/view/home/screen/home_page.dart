import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/home/bloc/home_bloc.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_bloc.dart';
import 'package:foody_bloc_app/view/home/screen/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}
