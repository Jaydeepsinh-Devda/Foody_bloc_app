import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class OnDetailsInitialState extends DetailsState {}

class OnGetPlaceDataState extends DetailsState {
  final PlaceListModel element;

  const OnGetPlaceDataState({required this.element});

  @override
  List<Object?> get props => [element, identityHashCode(this)];
}
