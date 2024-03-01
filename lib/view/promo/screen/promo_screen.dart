import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_card.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_heading.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_bloc.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_event.dart';
import 'package:foody_bloc_app/view/promo/bloc/promo_state.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  List<NotificationPromoModel> _list = [];
  late PromoBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<PromoBloc>();
    _bloc.add(GetListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<PromoBloc, PromoState>(
            listener: (context, state) async {
              if (state is OnGetListState) {
                _list = state.list;
              }
            },
            builder: (context, state) {
              return (_list.isEmpty)
                  ? const Center(child: CircularProgressIndicator())
                  : CustomScrollView(
                      slivers: [
                        NotificationAndPromoHeading(
                            headline: FoodyAppStrings.kHottestPromo),
                        _sliverList(),
                        NotificationAndPromoHeading(
                            headline: FoodyAppStrings.kRecommendedPromo),
                        _sliverList()
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget _sliverList() => SliverList.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return NotificationAndPromoCard(
            element: _list[index],
          );
        },
      );
}
