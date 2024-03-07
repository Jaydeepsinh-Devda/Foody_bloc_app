import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/data/profile_data.dart';
import 'package:foody_bloc_app/model/profile_model.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_event.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_state.dart';
import 'package:foody_bloc_app/data/profile_section_data.dart';
import 'package:foody_bloc_app/model/profile_section_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  List<ProfileSectionModel> _list = [];
  List<ProfileModel> _profileList = [];
  String _profileImage = "";
  ProfileBloc() : super(ProfileInitialState()) {
    on<GetProfileListEvent>(_getList);
    on<GetProfileImageEvent>(_getProfileImage);
  }

  FutureOr<void> _getList(
      GetProfileListEvent event, Emitter<ProfileState> emit) {
    _list = profileSectionData;
    _profileList = profileData;
    String initialLetter =
        "${profileData[0].firstName[0]}${profileData[0].lastName[0]}";

    emit(OnProfileGetListState(
        list: _list, profileList: _profileList, initialLetter: initialLetter));
  }

  FutureOr<void> _getProfileImage(
      GetProfileImageEvent event, Emitter<ProfileState> emit) async {
    emit(OnProfileLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    _profileImage =
        "https://i.pinimg.com/564x/99/60/d9/9960d90a6f69bddd40b9dd885c5da31f.jpg";

    emit(OnGetProfileImageState(profileImage: _profileImage));
  }
}
