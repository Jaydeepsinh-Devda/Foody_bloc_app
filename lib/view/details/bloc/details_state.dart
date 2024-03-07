import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/menu_model.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/model/review_model.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class OnDetailsInitialState extends DetailsState {}

class OnDetailsLoadingState extends DetailsState {}

class OnAboutTabLoadingState extends DetailsState {}

class OnMenuTabLoadingState extends DetailsState {}

class OnReviewTabLoadingState extends DetailsState {}

class OnGetPlaceDataState extends DetailsState {
  final PlaceListModel element;
  final List<MenuModel> foodList;
  final List<MenuModel> beverageList;
  final List<ReviewModel> reviewList;
  final double reservationPrice;

  const OnGetPlaceDataState(
      {required this.element,
      required this.foodList,
      required this.beverageList,
      required this.reviewList,
      required this.reservationPrice});

  @override
  List<Object?> get props =>
      [element, foodList, reviewList, identityHashCode(this)];
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

class OnSavedUnSavedState extends DetailsState {
  final bool isSaved;

  const OnSavedUnSavedState({required this.isSaved});

  @override
  List<Object?> get props => [isSaved, identityHashCode(this)];
}

class OnAboutTabGetData extends DetailsState {
  final String aboutPlace;

  const OnAboutTabGetData({required this.aboutPlace});

  @override
  List<Object?> get props => [aboutPlace, identityHashCode(this)];
}

class OnMenuTabGetData extends DetailsState {
  final List<MenuModel> foodList;
  final List<MenuModel> beverageList;

  const OnMenuTabGetData({required this.foodList, required this.beverageList});

  @override
  List<Object?> get props => [foodList, beverageList, identityHashCode(this)];
}

class OnReviewTabGetData extends DetailsState {
  final List<ReviewModel> reviewList;

  const OnReviewTabGetData({required this.reviewList});

  @override
  List<Object?> get props => [reviewList, identityHashCode(this)];
}
