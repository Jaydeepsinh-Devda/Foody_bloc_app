import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/profile/profile_event.dart';
import 'package:foody_bloc_app/bloc/profile/profile_state.dart';
import 'package:foody_bloc_app/data/profile_data.dart';
import 'package:foody_bloc_app/model/profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<ProfileModel> _list = [];
  String _profileImage = "";
  ProfileBloc() : super(ProfileInitialState()) {
    on<GetProfileListEvent>(_getList);
    on<GetProfileImageEvent>(_getProfileImage);
  }

  FutureOr<void> _getList(
      GetProfileListEvent event, Emitter<ProfileState> emit) {
    _list = profileData;
    emit(OnProfileGetListState(list: _list));
  }

  FutureOr<void> _getProfileImage(
      GetProfileImageEvent event, Emitter<ProfileState> emit) {
    _profileImage = "assets/images/profile.jpg";
    emit(OnGetProfileImageState(profileImage: _profileImage));
  }
}
