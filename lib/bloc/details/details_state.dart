import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class OnDetailsInitialState extends DetailsState {}

class OnDetailsLoadingState extends DetailsState {}

class OnGetPlaceDataState extends DetailsState {
  final PlaceListModel element;
  final List<MenuModel> foodList;
  final List<MenuModel> beverageList;
  final double reservationPrice;

  const OnGetPlaceDataState(
      {required this.element,
      required this.foodList,
      required this.beverageList,
      required this.reservationPrice});

  @override
  List<Object?> get props => [element, foodList, identityHashCode(this)];
}

class OnItemQuantityIncreaseAndDecreaseState extends DetailsState {
  final List<MenuModel> foodList;
  final List<MenuModel> beverageList;
  final int itemQuantityChange;
  final double totalOrderPrice;

  const OnItemQuantityIncreaseAndDecreaseState({
    required this.foodList,
    required this.beverageList,
    required this.itemQuantityChange,
    required this.totalOrderPrice,
  });

  @override
  List<Object?> get props => [
        foodList,
        beverageList,
        itemQuantityChange,
        totalOrderPrice,
        identityHashCode(this)
      ];
}
