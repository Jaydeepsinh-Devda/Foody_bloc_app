import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_bloc.dart';
import 'package:foody_bloc_app/view/profile/profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc(),
      child: const ProfileScreen(),
    );
  }
}
