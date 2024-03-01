import 'package:equatable/equatable.dart';

abstract class NotificationAndPromoEvent extends Equatable {
  const NotificationAndPromoEvent();

  @override
  List<Object?> get props => [];
}

class GetListEvent extends NotificationAndPromoEvent {}