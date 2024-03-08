import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/data/notification_data.dart';
import 'package:foody_bloc_app/model/notification_model.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_state.dart';

class PromoCubit extends Cubit<PromoState> {
  List<NotificationModel> _list = [];
  PromoCubit() : super(OnPromoInitialState());

  FutureOr<void> getList() {
    _list = notificationPromoData
        .where((element) =>
            element.notificationCategory == NotificationCategory.promo)
        .toList();

    getHottestPromoList();
    getRecommendedPromoList();
  }

  FutureOr<void> getHottestPromoList() async {
    emit(OnPromoLoadingState());

    await Future.delayed(const Duration(seconds: 4));

    List<NotificationModel> hottestPromoList = _list
        .where((element) => element.promoCategory == PromoCategory.hottest)
        .toList();

    emit(OnGetHottestPromoListState(hottestList: hottestPromoList));
  }

  FutureOr<void> getRecommendedPromoList() async {
    emit(OnPromoLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    List<NotificationModel> recommendationList = _list
        .where(
            (element) => element.promoCategory == PromoCategory.recommendation)
        .toList();

    emit(OnRecommendedPromoListState(recommendedList: recommendationList));
  }
}
