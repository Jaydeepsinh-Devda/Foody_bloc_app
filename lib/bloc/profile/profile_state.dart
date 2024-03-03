import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/profile_model.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class OnGetListState extends ProfileState {
  final List<ProfileModel> list;

  const OnGetListState({required this.list});

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}