import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/bloc/home/home_event.dart';
import 'package:foody_bloc_app/bloc/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<PlaceListModel> _placeList = [];

  HomeBloc() : super(OnHomeInitialState()) {
    on<GetListEvent>(_getList);
  }

  FutureOr<void> _getList(GetListEvent event, Emitter<HomeState> emit) {
    _placeList = placeListData;

    emit(OnGetListState(placeList: _placeList));
  }
}
