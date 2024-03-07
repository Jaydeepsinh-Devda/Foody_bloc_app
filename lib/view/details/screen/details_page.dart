import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/details/bloc/details_bloc.dart';
import 'package:foody_bloc_app/view/details/screen/details_screen.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsBloc>(
      create: (context) => DetailsBloc(),
      child: const DetailsScreen(),
    );
  }
}
