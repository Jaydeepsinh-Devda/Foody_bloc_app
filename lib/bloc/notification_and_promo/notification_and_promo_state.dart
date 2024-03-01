import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';

abstract class NotificationAndPromoState extends Equatable {
  const NotificationAndPromoState();

  @override
  List<Object?> get props => [];
}

class OnNotificationAndPromoInitialState extends NotificationAndPromoState {}

class OnGetListState extends NotificationAndPromoState {
  final List<NotificationPromoModel> list;

  const OnGetListState({required this.list});

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}
