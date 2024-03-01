import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_event.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_state.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';

class NotificationAndPromoBloc
    extends Bloc<NotificationAndPromoEvent, NotificationAndPromoState> {
      List<NotificationPromoModel> _list = [];
  NotificationAndPromoBloc() : super(OnNotificationAndPromoInitialState()){
   
  }
}