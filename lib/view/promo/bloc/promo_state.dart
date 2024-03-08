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
  const OnGetListState();
}

class OnGetHottestPromoListState extends PromoState {
  final List<NotificationModel> hottestList;

  const OnGetHottestPromoListState({required this.hottestList});

  @override
  List<Object?> get props => [hottestList];
}

class OnRecommendedPromoListState extends PromoState {
  final List<NotificationModel> recommendedList;

  const OnRecommendedPromoListState({required this.recommendedList});

  @override
  List<Object?> get props => [recommendedList];
}
