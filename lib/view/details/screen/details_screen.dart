import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/model/review_model.dart';
import 'package:foody_bloc_app/view/details/bloc/details_bloc.dart';
import 'package:foody_bloc_app/view/details/bloc/details_event.dart';
import 'package:foody_bloc_app/view/details/bloc/details_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/custom_button.dart';
import 'package:foody_bloc_app/view/details/widget/about_tab.dart';
import 'package:foody_bloc_app/view/details/widget/carousel.dart';
import 'package:foody_bloc_app/view/details/widget/menu_tab.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/space.dart';
import 'package:foody_bloc_app/view/details/widget/review_tab.dart';

class DetailsScreen extends StatefulWidget {
  static String tag = "/detail-screen";
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
  String _aboutPlace = "";
  late TabController _tabController;
  List<MenuModel> _foodList = [];
  List<MenuModel> _beverageList = [];
  List<ReviewModel> _reviewList = [];
  int _itemQuantity = 0;
  double _totalPrice = 0;
  bool _isSaved = false;

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
              _reviewList = state.reviewList;
              _totalPrice = state.reservationPrice;
            }
            if (state is OnItemQuantityIncreaseAndDecreaseState) {
              _foodList = state.foodList;
              _beverageList = state.beverageList;
              _totalPrice = state.totalOrderPrice;
            }
            if (state is OnSavedUnSavedState) {
              _isSaved = state.isSaved;
            }
            if (state is OnAboutTabGetData) {
              _aboutPlace = state.aboutPlace;
            }
            if (state is OnMenuTabGetData) {
              _foodList = state.foodList;
              _beverageList = state.beverageList;
            }
          },
          builder: (context, state) {
            return state is OnDetailsLoadingState
                ? const LoadingIndicator()
                : _nestedScrollView(state);
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

  Widget _nestedScrollView(DetailsState state) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _sliverToBoxAdapter(),
            _sliverPersistentHeader(),
          ];
        },
        body: _tabBarView(state),
      );

  Widget _sliverPersistentHeader() => SliverPersistentHeader(
        pinned: true,
        delegate: _CustomTabBar(tabBar: _tabBar()),
      );

  Widget _sliverToBoxAdapter() => SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Carousel(pageController: _pageController),
            const Space(height: 15),
            _placeNameAndLocation()
          ],
        ),
      );

  Widget _placeNameAndLocation() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _placeName(),
            _placeLocation(),
          ],
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
                _bottomSheetTextAndPrice(),
                const Space(width: 50),
                _reservationAndOrderButton()
              ],
            ),
          );
        },
      );

  Widget _bottomSheetTextAndPrice() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _countText(),
          _priceText(),
        ],
      );

  Widget _reservationAndOrderButton() => Expanded(
        child: CustomButton(
          text: _itemQuantity < 1
              ? Text(FoodyAppStrings.kReservation)
              : Text(FoodyAppStrings.kOrder),
          onPressed: () {},
        ),
      );

  Widget _countText() => Text(FoodyAppStrings.kCount);

  Widget _priceText() => Text(
        "${FoodyAppStrings.kINR} ${_totalPrice.toStringAsFixed(2)}",
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _detailsPlaceText() => Text(
        FoodyAppStrings.kDetailsPlace,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      );

  Widget _bookmarkIcon() => IconButton(
        onPressed: () {
          _bloc.add(SavedUnSavedEvent());
        },
        icon: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            return _isSaved
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.bookmark_border);
          },
        ),
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

  Widget _tabBarView(DetailsState state) => TabBarView(
        controller: _tabController,
        children: [
          AboutTab(
            element: _element,
            aboutPlace: _aboutPlace,
            bloc: _bloc,
            state: state,
          ),
          MenuTab(
            foodList: _foodList,
            beverageList: _beverageList,
            bloc: _bloc,
            state: state,
          ),
          ReviewTab(
            reviewList: _reviewList,
            bloc: _bloc,
            state: state,
          ),
        ],
      );
}

//! Another class for TabBar
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
