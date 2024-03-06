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

class ItemQuantityIncreaseAndDecreaseEvent extends DetailsEvent {
  final int id;
  final bool isIncrease;
  final bool isFood;

  const ItemQuantityIncreaseAndDecreaseEvent({
    required this.id,
    required this.isIncrease,
    required this.isFood,
  });

  @override
  List<Object?> get props => [id, isIncrease, isFood];
}
