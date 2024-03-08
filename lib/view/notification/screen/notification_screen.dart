import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/view/notification/bloc/notification_cubit.dart';
import 'package:foody_bloc_app/view/notification/bloc/notification_state.dart';
import 'package:foody_bloc_app/model/notification_model.dart';
import 'package:foody_bloc_app/ui_components/notification_and_promo_card.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/view/notification/widget/filter_option_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with AutomaticKeepAliveClientMixin {
  List<NotificationModel> _list = [];
  List<NotificationCategory> _notificationFilterList = [];
  int _selectedIndex = 0;
  late NotificationCubit _bloc;

  //! Widget Lifecycle Method
  @override
  void initState() {
    _bloc = context.read<NotificationCubit>();
    _bloc.getList();
    super.initState();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
  Widget _blocConsumer() => BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is OnGetListState) {
            _list = state.list;
            _notificationFilterList = state.notificationFilterList;
          }
          if (state is OnFilterListChangeState) {
            _list = state.list;
          }
        },
        builder: (context, state) {
          if (state is OnFilterOptionCardChange) {
            _selectedIndex = state.selectedIndex;
            _bloc.onFilterList();
          }
          return state is OnLoadingState
              ? const LoadingIndicator()
              : _customScrollView(state);
        },
      );

  Widget _customScrollView(NotificationState state) => CustomScrollView(
        slivers: [
          _sliverToBoxAdapter(),
          _sliverList(state),
        ],
      );

  Widget _sliverToBoxAdapter() => SliverToBoxAdapter(
        child: SizedBox(
          height: 50,
          width: 100,
          child: _filterOptionList(),
        ),
      );

  Widget _filterOptionList() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _notificationFilterList.length,
        itemBuilder: (context, index) {
          return FilterOptionCard(
            element: _notificationFilterList[index],
            index: _selectedIndex,
            bloc: _bloc,
          );
        },
      );

  Widget _sliverList(NotificationState state) =>
      state is OnFilterListLoadingState
          ? const SliverToBoxAdapter(
              child: LoadingIndicator(),
            )
          : SliverList.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return NotificationAndPromoCard(
                  element: _list[index],
                );
              },
            );

  @override
  bool get wantKeepAlive => true;
}
