import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/details/details_event.dart';
import 'package:foody_bloc_app/bloc/details/details_state.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  int _id = 0;
  late PlaceListModel element;
  DetailsBloc() : super(OnDetailsInitialState()) {
    on<GetPlaceDataEvent>(_getData);
  }

  FutureOr<void> _getData(GetPlaceDataEvent event, Emitter<DetailsState> emit) {
    _id = event.id;
    element = placeListData.singleWhere((element) => element.id == _id);

    emit(OnGetPlaceDataState(element: element));
  }
}
