import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_event.dart';
import 'package:foody_bloc_app/bloc/details/details_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/custom_button.dart';
import 'package:foody_bloc_app/ui_components/details/about_tab.dart';
import 'package:foody_bloc_app/ui_components/details/carousel.dart';
import 'package:foody_bloc_app/ui_components/details/menu_tab.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class DetailsScreen extends StatefulWidget {
  static String tag = "/details-screen";
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late Map arg;
  late DetailsBloc _bloc;
  PlaceListModel _element = placeListData[0];
  late TabController _tabController;
  List<MenuModel> _foodList = [];
  List<MenuModel> _beverageList = [];
  int _itemQuantity = 0;
  double _totalPrice = 0;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.7, initialPage: 1);
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    arg = ModalRoute.of(context)!.settings.arguments as Map;
    _bloc = context.read<DetailsBloc>();
    _bloc.add(GetPlaceDataEvent(id: arg['id']));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
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
          listener: (context, state) {
            if (state is OnGetPlaceDataState) {
              _element = state.element;
              _foodList = state.foodList;
              _beverageList = state.beverageList;
              _totalPrice = state.reservationPrice;
            }
            if (state is OnItemQuantityIncreaseAndDecreaseState) {
              _foodList = state.foodList;
              _beverageList = state.beverageList;
              _totalPrice = state.totalOrderPrice;
            }
          },
          builder: (context, state) {
            return state is OnDetailsLoadingState
                ? const LoadingIndicator()
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Carousel(pageController: _pageController),
                              const Space(height: 15),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
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
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _CustomTabBar(tabBar: _tabBar()),
                        )
                      ];
                    },
                    body: _tabBarView(),
                  );
          },
        ),
        bottomSheet: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            if (state is OnItemQuantityIncreaseAndDecreaseState) {
              _itemQuantity = state.itemQuantityChange;
            }
            return _bottomSheet();
          },
        ),
      );

  AppBar _appBar() => AppBar(
        title: _detailsPlaceText(),
        actions: [_bookmarkIcon()],
      );

  Widget _bottomSheet() => BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            height: 120,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(FoodyAppStrings.kCount),
                    Text(
                      "${FoodyAppStrings.kINR} ${_totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Space(width: 50),
                Expanded(
                  child: CustomButton(
                    text: _itemQuantity < 1
                        ? Text(FoodyAppStrings.kReservation)
                        : Text(FoodyAppStrings.kOrder),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          );
        },
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

  TabBar _tabBar() => TabBar(
        controller: _tabController,
        labelColor: Colors.red,
        indicatorColor: Colors.red,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: _tabBarTabsList(),
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

  Widget _tabBarView() => TabBarView(
        controller: _tabController,
        children: [
          AboutTab(element: _element),
          MenuTab(
              foodList: _foodList, beverageList: _beverageList, bloc: _bloc),
          const Text("Review"),
        ],
      );
}

class _CustomTabBar extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _CustomTabBar({required this.tabBar});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
