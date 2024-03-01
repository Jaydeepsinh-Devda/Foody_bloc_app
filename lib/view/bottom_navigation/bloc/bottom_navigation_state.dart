import 'package:equatable/equatable.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();
  @override
  List<Object?> get props => [];
}

class OnBottomNavigationInitialState extends BottomNavigationState {}

class OnBottomNavigationChangeState extends BottomNavigationState {
  final int index;
  const OnBottomNavigationChangeState({required this.index});

  @override
  List<Object?> get props => [index, identityHashCode(this)];
}
