import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/review_model.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/view/details/bloc/details_bloc.dart';
import 'package:foody_bloc_app/view/details/bloc/details_event.dart';
import 'package:foody_bloc_app/view/details/bloc/details_state.dart';

class ReviewTab extends StatefulWidget {
  final List<ReviewModel> reviewList;
  final DetailsBloc bloc;
  final DetailsState state;

  const ReviewTab({
    required this.bloc,
    required this.state,
    required this.reviewList,
    super.key,
  });

  @override
  State<ReviewTab> createState() => _ReviewTabState();
}

class _ReviewTabState extends State<ReviewTab>
    with AutomaticKeepAliveClientMixin {
      
  @override
  void initState() {
    widget.bloc.add(ReviewTabGetDataEvent());
    super.initState();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.state is OnReviewTabLoadingState
        ? const LoadingIndicator()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 20),
            child: CustomScrollView(
              slivers: [_sliverListBuilder()],
            ),
          );
  }

  //! Widget Methods
  Widget _sliverListBuilder() => SliverList.builder(
        itemCount: widget.reviewList.length,
        itemBuilder: (context, index) {
          return _reviewList(index);
        },
      );

  Widget _reviewList(int index) => ListTile(
        leading: _leadingIcon(),
        title: _reviewerName(index),
        subtitle: _review(index),
        trailing: _rating(index),
      );

  Widget _leadingIcon() => const CircleAvatar(child: Icon(Icons.person));

  Widget _reviewerName(int index) => Text(widget.reviewList[index].name);

  Widget _review(int index) => Text(widget.reviewList[index].review);

  Widget _rating(int index) =>
      Text("${widget.reviewList[index].rating} \u2605");

  @override
  bool get wantKeepAlive => true;
}
