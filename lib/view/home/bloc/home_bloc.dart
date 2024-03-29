import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/data/place_list_data.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/view/home/bloc/home_event.dart';
import 'package:foody_bloc_app/view/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<PlaceListModel> _placeList = [];

  HomeBloc() : super(OnHomeInitialState()) {
    on<GetHomeListEvent>(_getList);
  }

  FutureOr<void> _getList(
      GetHomeListEvent event, Emitter<HomeState> emit) async {
    emit(OnHomeLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    _placeList = placeListData;

    emit(OnHomeGetListState(placeList: _placeList));
  }
}
