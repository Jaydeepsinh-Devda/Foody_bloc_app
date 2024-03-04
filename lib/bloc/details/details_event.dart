import 'package:equatable/equatable.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class GetPlaceDataEvent extends DetailsEvent {
  final int id;

  const GetPlaceDataEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
