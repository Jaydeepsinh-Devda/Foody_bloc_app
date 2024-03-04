import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class OnProfileGetListState extends ProfileState {
  final List<ProfileModel> list;

  const OnProfileGetListState({required this.list});

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}

class OnGetProfileImageState extends ProfileState {
  final String profileImage;

  const OnGetProfileImageState({required this.profileImage});

  @override
  List<Object?> get props => [profileImage, identityHashCode(this)];
}
