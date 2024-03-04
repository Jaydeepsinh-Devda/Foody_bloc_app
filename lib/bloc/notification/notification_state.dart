import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class OnNotificationAndPromoInitialState extends NotificationState {}

class OnLoadingState extends NotificationState {}

class OnGetListState extends NotificationState {
  final List<NotificationPromoModel> list;

  const OnGetListState({required this.list});

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}
