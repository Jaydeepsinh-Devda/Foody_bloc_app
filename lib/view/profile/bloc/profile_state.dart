import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/profile_model.dart';
import 'package:foody_bloc_app/model/profile_section_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class OnProfileLoadingState extends ProfileState {}

class OnProfileGetListState extends ProfileState {
  final List<ProfileSectionModel> list;
  final List<ProfileModel> profileList;
  final String initialLetter;

  const OnProfileGetListState(
      {required this.profileList,
      required this.list,
      required this.initialLetter});

  @override
  List<Object?> get props =>
      [list, profileList, initialLetter, identityHashCode(this)];
}

class OnGetProfileImageState extends ProfileState {
  final String profileImage;

  const OnGetProfileImageState({required this.profileImage});

  @override
  List<Object?> get props => [profileImage, identityHashCode(this)];
}
