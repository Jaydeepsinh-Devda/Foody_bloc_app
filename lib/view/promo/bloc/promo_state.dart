import 'package:equatable/equatable.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';

abstract class PromoState extends Equatable {
  const PromoState();
  @override
  List<Object?> get props => [];
}

class OnPromoInitialState extends PromoState {}

class OnGetListState extends PromoState {
  final List<NotificationPromoModel> list;

  const OnGetListState({required this.list});

  @override
  List<Object?> get props => [list, identityHashCode(this)];
}