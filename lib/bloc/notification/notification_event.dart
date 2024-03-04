import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class GetListEvent extends NotificationEvent {
  final bool isPromoScreen;

  const GetListEvent({required this.isPromoScreen});

  @override
  List<Object?> get props => [isPromoScreen];
}
