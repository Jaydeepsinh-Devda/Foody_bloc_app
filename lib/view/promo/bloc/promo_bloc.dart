import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/data/notification_promo_data.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_event.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_state.dart';

class PromoBloc extends Bloc<PromoEvent, PromoState> {
  List<NotificationPromoModel> _list = [];
  PromoBloc() : super(OnPromoInitialState()) {
    on<GetListEvent>(_getList);
  }

  FutureOr<void> _getList(GetListEvent event, Emitter<PromoState> emit) {
    _list = notificationPromoData
        .where((element) => element.category == NotificationCategory.promo)
        .toList();

    emit(OnGetListState(list: _list));
  }
}
