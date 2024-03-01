import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
  @override
  List<Object?> get props => [];
}

class BottomNavigationClickEvent extends BottomNavigationEvent {
  final int index;
  const BottomNavigationClickEvent({required this.index});

  @override
  List<Object?> get props => [index];
}