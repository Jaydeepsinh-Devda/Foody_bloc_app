import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/data/review_data.dart';
import 'package:foody_bloc_app/model/review_model.dart';
import 'package:foody_bloc_app/view/details/bloc/details_event.dart';
import 'package:foody_bloc_app/view/details/bloc/details_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/test.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final List<MenuModel> _menuList = [];
  final List<MenuModel> _foodList = [];
  final List<MenuModel> _beverageList = [];
  final List<ReviewModel> _reviewList = [];
  String _aboutPlace = "";
  int _id = 0;
  bool _isSaved = false;
  late PlaceListModel element;
  double _totalPrice = 0;

  DetailsBloc() : super(OnDetailsInitialState()) {
    on<GetPlaceDataEvent>(_getData);
    on<ItemQuantityIncreaseAndDecreaseEvent>(_increaseOrDecreaseQuantityValue);
    on<SavedUnSavedEvent>(_onSavedButtonClick);
    on<AboutTabGetDataEvent>(_aboutGetData);
    on<MenuTabGetDataEvent>(_menuGetData);
    on<ReviewTabGetDataEvent>(_reviewGetData);
  }

  FutureOr<void> _getData(
      GetPlaceDataEvent event, Emitter<DetailsState> emit) async {
    emit(OnDetailsLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    _id = event.id;
    element = placeListData.singleWhere((element) => element.id == _id);
    _menuList.addAll(Test().menuData);

    for (int itemId in element.menuItems) {
      _foodList.addAll(_menuList.where((element) =>
          element.id == itemId &&
          element.menuCategory.name == FoodyAppStrings.kFood.toLowerCase()));
      _beverageList.addAll(_menuList.where((element) =>
          element.id == itemId &&
          element.menuCategory.name ==
              FoodyAppStrings.kBeverage.toLowerCase()));
    }

    _reviewList.addAll(reviewData);

    placeListData.where((place) => place.id == _id).forEach((place) {
      _totalPrice = place.reservationPrice;
    });

    emit(OnGetPlaceDataState(
      element: element,
      foodList: _foodList,
      beverageList: _beverageList,
      reservationPrice: _totalPrice,
      reviewList: _reviewList,
    ));
  }

  FutureOr<void> _increaseOrDecreaseQuantityValue(
      ItemQuantityIncreaseAndDecreaseEvent event, Emitter<DetailsState> emit) {
    List<MenuModel> itemList = event.isFood ? _foodList : _beverageList;

    for (int i = 0; i < itemList.length; i++) {
      if (itemList[i].id == event.id) {
        itemList[i] = event.isIncrease
            ? itemList[i]
                .copyWith(itemQuantity: () => itemList[i].itemQuantity + 1)
            : itemList[i]
                .copyWith(itemQuantity: () => itemList[i].itemQuantity - 1);
        break;
      }
    }

    int totalQuantity = 0;

    for (int i = 0; i < _foodList.length; i++) {
      totalQuantity += _foodList[i].itemQuantity;
    }

    for (int i = 0; i < _beverageList.length; i++) {
      totalQuantity += _beverageList[i].itemQuantity;
    }

    double totalPrice = _totalPrice;

    for (int i = 0; i < _foodList.length; i++) {
      totalPrice += _foodList[i].itemPrice * _foodList[i].itemQuantity;
    }

    for (int i = 0; i < _beverageList.length; i++) {
      totalPrice += _beverageList[i].itemPrice * _beverageList[i].itemQuantity;
    }

    emit(
      OnItemQuantityIncreaseAndDecreaseState(
        foodList: _foodList,
        beverageList: _beverageList,
        itemQuantityChange: totalQuantity,
        totalOrderPrice: totalPrice,
      ),
    );
  }

  FutureOr<void> _onSavedButtonClick(
      SavedUnSavedEvent event, Emitter<DetailsState> emit) {
    _isSaved = !_isSaved;
    emit(OnSavedUnSavedState(isSaved: _isSaved));
  }

  FutureOr<void> _aboutGetData(
      AboutTabGetDataEvent event, Emitter<DetailsState> emit) async {
    emit(OnAboutTabLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    _aboutPlace = element.aboutPlace;

    emit(OnAboutTabGetData(aboutPlace: _aboutPlace));
  }

  FutureOr<void> _menuGetData(
      MenuTabGetDataEvent event, Emitter<DetailsState> emit) async {
    emit(OnMenuTabLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(OnMenuTabGetData(foodList: _foodList, beverageList: _beverageList));
  }

  FutureOr<void> _reviewGetData(
      ReviewTabGetDataEvent event, Emitter<DetailsState> emit) async {
    emit(OnReviewTabLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    emit(OnReviewTabGetData(reviewList: _reviewList));
  }
}
