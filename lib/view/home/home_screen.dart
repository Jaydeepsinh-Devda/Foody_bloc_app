import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_event.dart';
import 'package:foody_bloc_app/bloc/profile/profile_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/space.dart';
import 'package:foody_bloc_app/bloc/home/home_bloc.dart';
import 'package:foody_bloc_app/bloc/home/home_event.dart';
import 'package:foody_bloc_app/bloc/home/home_state.dart';
import 'package:foody_bloc_app/ui_components/home/list_heading_and_view_all_text.dart';
import 'package:foody_bloc_app/ui_components/home/popular_card.dart';
import 'package:foody_bloc_app/ui_components/home/recommended_list.dart';

class HomeScreen extends StatefulWidget {
  static String tag = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlaceListModel> _placeList = [];
  String _profileImagePath = "";
  late HomeBloc _homeBloc;
  late ProfileBloc _profileBloc;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _homeBloc.add(GetHomeListEvent());

    _profileBloc = context.read<ProfileBloc>();
    _profileBloc.add(GetProfileImageEvent());
    super.initState();
  }

  //!  Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _multiBlocListener(),
      ),
    );
  }

  //! Widget Method
  Widget _multiBlocListener() => MultiBlocListener(
        listeners: [
          _homeBlocListener(),
          _profileBlocListener(),
        ],
        child: _homeBlocBuilder(),
      );

  Widget _homeBlocBuilder() => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                _sliverToBoxAdapter(),
                PopularList(list: _placeList),
              ],
            ),
          );
        },
      );

  BlocListener _homeBlocListener() => BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is OnHomeGetListState) {
            _placeList = state.placeList;
          }
        },
      );

  BlocListener _profileBlocListener() =>
      BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is OnGetProfileImageState) {
            _profileImagePath = state.profileImage;
          }
        },
      );

  Widget _sliverToBoxAdapter() => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _goodMorningTextAndCircularAvatar(),
            const Space(height: 20),
            _userBalanceCard(),
            const Space(height: 30),
            ListHeadingAndViewAllText(
                headingText: FoodyAppStrings.kRecommendedPlace),
            const Space(height: 10),
            RecommendedList(list: _placeList),
            const Space(height: 30),
            ListHeadingAndViewAllText(
                headingText: FoodyAppStrings.kPopularPlace),
            const Space(height: 10),
          ],
        ),
      );

  Widget _goodMorningTextAndCircularAvatar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _goodMorningAndItsLaunchTimeText(),
          _profileBlocBuilder(),
        ],
      );
  Widget _goodMorningAndItsLaunchTimeText() => RichText(
        text: TextSpan(
          children: [
            _goodMorningText(),
            _itsLaunchTimeText(),
          ],
        ),
      );

  TextSpan _goodMorningText() => TextSpan(
        text: FoodyAppStrings.kHomePageGoodMorningText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );

  TextSpan _itsLaunchTimeText() => TextSpan(
        text: "\n${FoodyAppStrings.kItsLaunchTime}",
        style: const TextStyle(color: Colors.black),
      );

  Widget _profileBlocBuilder() => BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return _profileImage();
        },
      );

  Widget _profileImage() => CircleAvatar(
        child: ClipOval(
          child: _profileImagePath.isEmpty
              ? const LoadingIndicator()
              : Image.asset(_profileImagePath),
        ),
      );

  Widget _userBalanceCard() => SizedBox(
        height: 100,
        child: Card(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _yourBalanceCardText(),
              _balance(),
            ],
          ),
        ),
      );

  Widget _yourBalanceCardText() => Text(
        FoodyAppStrings.kYourCardBalance,
        style: const TextStyle(color: Colors.white70),
      );

  Widget _balance() => Text(
        FoodyAppStrings.kINR125,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
}