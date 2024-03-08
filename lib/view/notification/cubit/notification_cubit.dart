import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/notification/cubit/notification_state.dart';
import 'package:foody_bloc_app/data/notification_data.dart';
import 'package:foody_bloc_app/model/notification_model.dart';

class NotificationCubit extends Cubit<NotificationState> {
  List<NotificationModel> _list = [];
  final List<NotificationCategory> _notificationFilterList = [];
  int _selectedIndex = 0;
  NotificationCubit() : super(OnNotificationAndInitialState());

  FutureOr<void> getList() async {
    emit(OnLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    _notificationFilterList.addAll(NotificationCategory.values);

    _list = notificationPromoData;

    emit(
      OnGetListState(
          list: _list, notificationFilterList: _notificationFilterList),
    );
  }

  FutureOr<void> onFilterList() async {
    emit(OnFilterListLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    if (_selectedIndex == 0) {
      _list = notificationPromoData;
    } else {
      _list = notificationPromoData
          .where(
              (element) => element.notificationCategory.index == _selectedIndex)
          .toList();
    }

    emit(OnFilterListChangeState(list: _list));
  }

  FutureOr<void> onFilterCardIndexChange(int selectedIndex) {
    _selectedIndex = selectedIndex;
    emit(OnFilterOptionCardChange(selectedIndex: selectedIndex));
  }
}
