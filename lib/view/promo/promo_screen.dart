import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/notification_model.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_card.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_heading.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/view/promo/cubit/promo_cubit.dart';
import 'package:foody_bloc_app/view/promo/cubit/promo_state.dart';

class PromoScreen extends StatefulWidget {
  const PromoScreen({super.key});

  @override
  State<PromoScreen> createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  List<NotificationModel> _hottestList = [];
  List<NotificationModel> _recommendationList = [];
  late PromoCubit _bloc;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _bloc = context.read<PromoCubit>();
    _bloc.getList();
    super.initState();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: _blocConsumer(),
        ),
      ),
    );
  }

  //! Widget Methods
  Widget _blocConsumer() => _customScrollView();

  Widget _customScrollView() => CustomScrollView(
        slivers: [
          NotificationAndPromoHeading(headline: FoodyAppStrings.kHottestPromo),
          _buildHottestList(),
          NotificationAndPromoHeading(
              headline: FoodyAppStrings.kRecommendedPromo),
          _buildRecommendedList()
        ],
      );

  Widget _buildHottestList() => BlocBuilder<PromoCubit, PromoState>(
        buildWhen: (previous, current) => current is OnGetHottestPromoListState,
        builder: (context, state) {
          if (state is OnGetHottestPromoListState) {
            _hottestList = state.hottestList;
          }
          return state is OnPromoLoadingState
              ? const SliverToBoxAdapter(
                  child: LoadingIndicator(),
                )
              : _sliverList(_hottestList);
        },
      );

  Widget _buildRecommendedList() => BlocBuilder<PromoCubit, PromoState>(
        buildWhen: (previous, current) =>
            current is OnRecommendedPromoListState,
        builder: (context, state) {
          if (state is OnRecommendedPromoListState) {
            _recommendationList = state.recommendedList;
          }
          return state is OnPromoLoadingState
              ? const SliverToBoxAdapter(
                  child: LoadingIndicator(),
                )
              : _sliverList(_recommendationList);
        },
      );

  Widget _sliverList(List<NotificationModel> list) => SliverList.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return NotificationAndPromoCard(
            element: list[index],
          );
        },
      );
}
