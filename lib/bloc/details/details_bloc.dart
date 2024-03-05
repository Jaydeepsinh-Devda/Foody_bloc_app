import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_event.dart';
import 'package:foody_bloc_app/bloc/details/details_state.dart';
import 'package:foody_bloc_app/data/menu_data.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final List<MenuModel> _foodList = [];
  final List<MenuModel> _beverageList = [];
  int _id = 0;
  late PlaceListModel element;

  DetailsBloc() : super(OnDetailsInitialState()) {
    on<GetPlaceDataEvent>(_getData);
    on<ItemQuantityIncreaseAndDecreaseEvent>(_increaseOrDecreaseQuantityValue);
  }

  FutureOr<void> _getData(GetPlaceDataEvent event, Emitter<DetailsState> emit) {
    _id = event.id;
    element = placeListData.singleWhere((element) => element.id == _id);

    for (int itemId in element.menuItems) {
      _foodList.addAll(menuData.where(
          (menu) => menu.id == itemId && menu.menuCategory.name == "food"));
      _beverageList.addAll(menuData.where(
          (menu) => menu.id == itemId && menu.menuCategory.name == "beverage"));
    }

    emit(OnGetPlaceDataState(
      element: element,
      foodList: _foodList,
      beverageList: _beverageList,
    ));
  }

  FutureOr<void> _increaseOrDecreaseQuantityValue(
      ItemQuantityIncreaseAndDecreaseEvent event, Emitter<DetailsState> emit) {
    for (int i = 0; i < _foodList.length; i++) {
      if (event.isIncrease && _foodList[i].id == event.id) {
        _foodList[i].itemQuantity = _foodList[i].itemQuantity + 1;
      }
      if (!event.isIncrease && _foodList[i].id == event.id) {
        _foodList[i].itemQuantity = _foodList[i].itemQuantity - 1;
      }
    }

    emit(
      OnItemQuantityIncreaseAndDecreaseState(list: _foodList),
    );
  }
}
