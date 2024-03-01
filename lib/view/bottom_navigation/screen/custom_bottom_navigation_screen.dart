import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/bottom_navigation/bloc/bottom_navigation_bloc.dart';
import 'package:foody_bloc_app/view/bottom_navigation/bloc/bottom_navigation_event.dart';
import 'package:foody_bloc_app/view/bottom_navigation/bloc/bottom_navigation_state.dart';
import 'package:foody_bloc_app/view/home/screen/home_page.dart';
import 'package:foody_bloc_app/view/notification/screen/notification_screen.dart';
import 'package:foody_bloc_app/view/profile/screen/profile_screen.dart';
import 'package:foody_bloc_app/view/promo/screen/promo_page.dart';

class CustomBottomNavigationBarScreen extends StatefulWidget {
  const CustomBottomNavigationBarScreen({super.key});

  @override
  State<CustomBottomNavigationBarScreen> createState() =>
      _CustomBottomNavigationBarScreenState();
}

class _CustomBottomNavigationBarScreenState
    extends State<CustomBottomNavigationBarScreen> {
  int currentPageIndex = 0;
  late BottomNavigationBloc _bloc;

  final List<Widget> _pages = const [
    HomePage(),
    PromoPage(),
    NotificationScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    _bloc = context.read<BottomNavigationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        if (state is OnBottomNavigationChangeState) {
          currentPageIndex = state.index;
        }
        return Scaffold(
            body: _pages.elementAt(currentPageIndex),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (index) {
                _bloc.add(BottomNavigationClickEvent(index: index));
              },
              selectedIndex: currentPageIndex,
              indicatorColor: Colors.transparent,
              destinations: <NavigationDestination>[
                _navigationItem(
                    label: "Home",
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home),
                _navigationItem(
                    label: "Promo",
                    icon: Icons.local_offer_outlined,
                    selectedIcon: Icons.local_offer),
                _navigationItem(
                    label: "Notification",
                    icon: Icons.notifications_none_sharp,
                    selectedIcon: Icons.notifications),
                _navigationItem(
                    label: "Profile",
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person_rounded)
              ],
            ));
      },
    );
  }

  NavigationDestination _navigationItem(
      {required String label, required icon, required selectedIcon}) {
    return NavigationDestination(
      selectedIcon: Icon(
        selectedIcon,
        color: Colors.red,
      ),
      icon: Icon(icon),
      label: label,
    );
  }
}
