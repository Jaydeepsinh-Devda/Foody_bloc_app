import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_event.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_state.dart';
import 'package:foody_bloc_app/data/notification_promo_data.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';

class NotificationAndPromoBloc
    extends Bloc<NotificationAndPromoEvent, NotificationAndPromoState> {
  List<NotificationPromoModel> _list = [];
  bool isPromoScreen = false;
  NotificationAndPromoBloc() : super(OnNotificationAndPromoInitialState()) {
    on<GetListEvent>(_getList);
  }

  FutureOr<void> _getList(
      GetListEvent event, Emitter<NotificationAndPromoState> emit) async {
    emit(OnLoadingState());

    await Future.delayed(const Duration(seconds: 3));

    isPromoScreen = event.isPromoScreen;

    if (isPromoScreen) {
      _list = notificationPromoData
          .where((element) =>
              element.notificationCategory == NotificationCategory.promo)
          .toList();
    } else {
      _list = notificationPromoData;
    }
    emit(
      OnGetListState(list: _list),
    );
  }
}
