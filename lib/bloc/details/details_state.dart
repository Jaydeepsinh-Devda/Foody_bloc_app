import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class OnDetailsInitialState extends DetailsState {}

class OnGetPlaceDataState extends DetailsState {
  final PlaceListModel element;
  final List<MenuModel> foodList;
  final List<MenuModel> beverageList;

  const OnGetPlaceDataState({
    required this.element,
    required this.foodList,
    required this.beverageList,
  });

  @override
  List<Object?> get props => [element, foodList, identityHashCode(this)];
}

class OnItemQuantityIncreaseAndDecreaseState extends DetailsState {
  final List<MenuModel> list;

  const OnItemQuantityIncreaseAndDecreaseState({required this.list});

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}