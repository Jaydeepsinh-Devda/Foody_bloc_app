import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_bloc.dart';
import 'package:foody_bloc_app/view/promo/screen/promo_screen.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PromoBloc>(
      create: (context) => PromoBloc(),
      child: const PromoScreen(),
    );
  }
}
