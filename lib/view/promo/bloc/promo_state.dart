import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/notification_model.dart';

abstract class PromoState extends Equatable {
  const PromoState();

  @override
  List<Object?> get props => [];
}

class OnPromoInitialState extends PromoState {}

class OnPromoLoadingState extends PromoState {}

class OnGetListState extends PromoState {
  final List<NotificationModel> hottestList;
  final List<NotificationModel> recommendationList;

  const OnGetListState(
      {required this.hottestList, required this.recommendationList});

  @override
  List<Object?> get props =>
      [hottestList, recommendationList, identityHashCode(this)];
}
