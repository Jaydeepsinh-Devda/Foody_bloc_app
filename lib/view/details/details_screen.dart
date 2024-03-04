import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_event.dart';
import 'package:foody_bloc_app/bloc/details/details_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/details/carousel.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class DetailsScreen extends StatefulWidget {
  static String tag = "/details-screen";
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late PageController _pageController;
  late Map arg;
  late DetailsBloc _bloc;
  PlaceListModel _element = placeListData[0];

  //! Widget Lifecycle Method
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7, initialPage: 1);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    arg = ModalRoute.of(context)!.settings.arguments as Map;
    _bloc = context.read<DetailsBloc>();
    _bloc.add(GetPlaceDataEvent(id: arg['id']));
    super.didChangeDependencies();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  //! Widget Methods
  Widget _buildScaffold() => Scaffold(
        appBar: _appBar(),
        body: BlocConsumer<DetailsBloc, DetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is OnGetPlaceDataState) {
              _element = state.element;
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Carousel(pageController: _pageController),
                      const Space(height: 15),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _placeName(),
                            _placeLocation(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  child: _tabBar(),
                )
              ],
            );
          },
        ),
      );

  AppBar _appBar() => AppBar(
        title: _detailsPlaceText(),
        actions: [_bookmarkIcon()],
      );

  Widget _detailsPlaceText() => Text(
        FoodyAppStrings.kDetailsPlace,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );

  Widget _bookmarkIcon() => IconButton(
        onPressed: () {},
        icon: const Icon(Icons.bookmark_outline_rounded),
      );

  Widget _placeName() => Text(
        _element.placeName,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _placeLocation() => Text(_element.placeLocation);

  Widget _tabBar() => DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: _tabBarTabsList(),
            ),
            SizedBox(
              height: 200,
              child: const TabBarView(
                children: [
                  Text("About"),
                  Text("Menu"),
                  Text("Reviews"),
                ],
              ),
            )
          ],
        ),
      );

  List<Widget> _tabBarTabsList() => [
        _tabBarTab(text: FoodyAppStrings.kAbout),
        _tabBarTab(text: FoodyAppStrings.kMenu),
        _tabBarTab(text: FoodyAppStrings.kReviews)
      ];

  Widget _tabBarTab({required String text}) => Tab(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
