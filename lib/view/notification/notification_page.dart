import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_bloc.dart';
import 'package:foody_bloc_app/view/notification/notification_screen.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationAndPromoBloc>(
      create: (context) => NotificationAndPromoBloc(),
      child: const NotificationScreen(),
    );
  }
}
