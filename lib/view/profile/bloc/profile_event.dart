import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class GetProfileListEvent extends ProfileEvent {}

class GetProfileImageEvent extends ProfileEvent {}
