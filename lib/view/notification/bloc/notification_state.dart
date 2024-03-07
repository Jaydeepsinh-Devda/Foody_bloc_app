import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/notification_model.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class OnNotificationAndInitialState extends NotificationState {}

class OnLoadingState extends NotificationState {}

class OnFilterListLoadingState extends NotificationState {}

class OnGetListState extends NotificationState {
  final List<NotificationModel> list;
  final List<NotificationCategory> notificationFilterList;

  const OnGetListState(
      {required this.list, required this.notificationFilterList});

  @override
  List<Object?> get props =>
      [list, notificationFilterList, identityHashCode(this)];
}


class OnFilterListChangeState extends NotificationState {
  final List<NotificationModel> list;

  const OnFilterListChangeState({
    required this.list,
  });

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}

class OnFilterOptionCardChange extends NotificationState {
  final int selectedIndex;

  const OnFilterOptionCardChange({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex, identityHashCode(this)];
}
