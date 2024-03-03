import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_bloc.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_event.dart';
import 'package:foody_bloc_app/bloc/notification_and_promo/notification_and_promo_state.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_card.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_heading.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationPromoModel> _list = [];
  late NotificationAndPromoBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<NotificationAndPromoBloc>();
    _bloc.add(const GetListEvent(isPromoScreen: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child:
              BlocConsumer<NotificationAndPromoBloc, NotificationAndPromoState>(
            listener: (context, state) {
              if (state is OnGetListState) {
                _list = state.list;
              }
            },
            builder: (context, state) {
              return _list.isEmpty
                  ? _loadingIndicator()
                  : CustomScrollView(
                      slivers: [
                        NotificationAndPromoHeading(
                            headline: FoodyAppStrings.kToday),
                        _sliverList(itemCount: 3),
                        NotificationAndPromoHeading(
                          headline: FoodyAppStrings.kYesterday,
                        ),
                        _sliverList(itemCount: 1)
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _sliverList({required int itemCount}) => SliverList.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return NotificationAndPromoCard(
            element: _list[index],
          );
        },
      );

  Widget _loadingIndicator() => const Center(
        child: CircularProgressIndicator(),
      );
}