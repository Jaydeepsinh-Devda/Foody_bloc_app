import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class OnHomeInitialState extends HomeState {}

class OnHomeGetListState extends HomeState {
  final List<PlaceListModel> placeList;

  const OnHomeGetListState({
    required this.placeList,
  });

  @override
  List<Object?> get props => [placeList, identityHashCode(this)];
}
