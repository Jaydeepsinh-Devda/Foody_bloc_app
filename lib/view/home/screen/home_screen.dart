import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/space.dart';
import 'package:foody_bloc_app/view/home/bloc/home_bloc.dart';
import 'package:foody_bloc_app/view/home/bloc/home_event.dart';
import 'package:foody_bloc_app/view/home/bloc/home_state.dart';
import 'package:foody_bloc_app/view/home/widgets/list_heading_and_view_all_text.dart';
import 'package:foody_bloc_app/view/home/widgets/popular_card.dart';
import 'package:foody_bloc_app/view/home/widgets/recommended_card.dart';

class HomeScreen extends StatefulWidget {
  final String tag = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlaceListModel> _placeList = [];
  late HomeBloc _bloc;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _bloc = context.read<HomeBloc>();
    _bloc.add(GetListEvent());
    super.initState();
  }

  //!  Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[20],
      body: SafeArea(
        child: _blocConsumer(),
      ),
    );
  }

  //! Widget Method
  Widget _blocConsumer() => BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is OnGetListState) {
            _placeList = state.placeList;
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                _sliverToBoxAdapter(),
                _popularPlaceListCard(),
              ],
            ),
          );
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
            _recommendedHorizontalList(),
            const Space(height: 30),
            ListHeadingAndViewAllText(
                headingText: FoodyAppStrings.kPopularPlace),
            const Space(height: 10),
          ],
        ),
      );

  Widget _recommendedHorizontalList() => SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _placeList.length,
          itemBuilder: (context, index) {
            return RecommendedCard(element: _placeList[index]);
          },
        ),
      );

  Widget _goodMorningTextAndCircularAvatar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: FoodyAppStrings.kHomePageGoodMorningText,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextSpan(
                  text: "\n${FoodyAppStrings.kItsLaunchTime}",
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.red,
          )
        ],
      );

  Widget _userBalanceCard() => SizedBox(
        height: 100,
        child: Card(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                FoodyAppStrings.kYourCardBalance,
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                FoodyAppStrings.kINR125,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      );

  Widget _popularPlaceListCard() => SliverList.builder(
        itemCount: _placeList.length,
        itemBuilder: (context, index) {
          return PopularCard(element: _placeList[index]);
        },
      );
}
