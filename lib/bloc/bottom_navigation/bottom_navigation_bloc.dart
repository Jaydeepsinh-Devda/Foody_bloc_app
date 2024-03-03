import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:foody_bloc_app/bloc/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(OnBottomNavigationInitialState()) {
    on<BottomNavigationClickEvent>(_onBottomNavigationBarClick);
  }

  FutureOr<void> _onBottomNavigationBarClick(
      BottomNavigationClickEvent event, Emitter<BottomNavigationState> emit) {
    emit(OnBottomNavigationChangeState(index: event.index));
  }
}
