import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_event.dart';
import 'package:foody_bloc_app/bloc/profile/profile_state.dart';
import 'package:foody_bloc_app/data/profile_data.dart';
import 'package:foody_bloc_app/model/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<ProfileModel> _list = [];
  ProfileBloc() : super(ProfileInitialState()){
    on<GetListEvent>(_getList);
  }

  FutureOr<void> _getList(GetListEvent event, Emitter<ProfileState> emit){
    _list = profileData;
    emit(OnGetListState(list: _list));
  }
}
