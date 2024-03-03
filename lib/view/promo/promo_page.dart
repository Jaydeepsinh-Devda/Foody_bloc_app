import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_bloc.dart';
import 'package:foody_bloc_app/view/promo/promo_screen.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationAndPromoBloc>(
      create: (context) => NotificationAndPromoBloc(),
      child: const PromoScreen(),
    );
  }
}