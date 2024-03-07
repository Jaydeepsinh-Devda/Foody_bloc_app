import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_bloc.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_event.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/space.dart';
import 'package:foody_bloc_app/view/home/bloc/home_bloc.dart';
import 'package:foody_bloc_app/view/home/bloc/home_event.dart';
import 'package:foody_bloc_app/view/home/bloc/home_state.dart';
import 'package:foody_bloc_app/view/home/widget/list_heading_and_view_all_text.dart';
import 'package:foody_bloc_app/view/home/widget/popular_list.dart';
import 'package:foody_bloc_app/view/home/widget/recommended_list.dart';

class HomeScreen extends StatefulWidget {
  static String tag = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  List<PlaceListModel> _placeList = [];
  late HomeBloc _homeBloc;
  String initialLetter = "";
  late ProfileBloc _profileBloc;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    _profileBloc = context.read<ProfileBloc>();
    _profileBloc.add(GetProfileListEvent());
    _profileBloc.add(GetProfileImageEvent());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  //!  Build Method
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: _blocConsumer(),
      ),
    );
  }

  //! Widget Method
  Widget _blocConsumer() => BlocConsumer<HomeBloc, HomeState>(
        listener: (context, homeState) {
          if (homeState is OnHomeGetListState) {
            _placeList = homeState.placeList;
          }
        },
        builder: (context, homeState) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, profileState) {
                return _customScrollView(homeState, profileState);
              },
            ),
          );
        },
      );

  Widget _customScrollView(HomeState homeState, ProfileState profileState) =>
      CustomScrollView(
        slivers: [
          _sliverToBoxAdapter(homeState, profileState),
          PopularList(
            list: _placeList,
            state: homeState,
            profileState: profileState,
          ),
        ],
      );

  Widget _sliverToBoxAdapter(HomeState homeState, ProfileState profileState) =>
      SliverToBoxAdapter(
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
            (homeState is OnHomeLoadingState ||
                    profileState is OnProfileLoadingState)
                ? const LoadingIndicator()
                : RecommendedList(list: _placeList),
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

  Widget _profileBlocBuilder() => BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is OnProfileGetListState) {
            initialLetter = state.initialLetter;
          }
          if (state is OnGetProfileImageState) {
            _homeBloc.add(GetHomeListEvent());
          }
        },
        builder: (context, state) {
          return _profileImage(state);
        },
      );

  Widget _profileImage(ProfileState state) => CircleAvatar(
        child: ClipOval(
          child: state is OnGetProfileImageState
              ? Image.network(state.profileImage)
              : Text(initialLetter),
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
