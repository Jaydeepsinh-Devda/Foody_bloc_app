import 'package:flutter/material.dart';
import 'package:foody_bloc_app/view/details/screen/details_screen.dart';
import 'package:foody_bloc_app/view/home/bloc/home_state.dart';
import 'package:foody_bloc_app/view/profile/bloc/profile_state.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class PopularList extends StatelessWidget {
  final List<PlaceListModel> list;
  final HomeState state;
  final ProfileState profileState;
  const PopularList({
    required this.list,
    required this.state,
    required this.profileState,
    super.key,
  });

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return (state is OnHomeLoadingState ||
            profileState is OnProfileLoadingState)
        ? const SliverToBoxAdapter(
            child: LoadingIndicator(),
          )
        : _sliverList();
  }

  //! Widget Methods

  Widget _sliverList() => SliverList.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.tag,
                  arguments: {'id': list[index].id});
            },
            child: _popularListCard(index),
          );
        },
      );

  Widget _popularListCard(int index) => SizedBox(
        height: 150,
        child: Card(
          color: const Color(0xFFFFFFFF),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                _popularListCardImage(index),
                const Space(width: 10),
                _popularListCardPlaceDetails(index)
              ],
            ),
          ),
        ),
      );

  Widget _popularListCardImage(int index) => Container(
        clipBehavior: Clip.antiAlias,
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          list[index].imageUrl,
          fit: BoxFit.cover,
        ),
      );

  Widget _popularListCardPlaceDetails(int index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _placeName(index),
          _placeDetail(index),
          _popularListCardRatingAndReview(index)
        ],
      );

  Widget _placeName(int index) => Text(
        list[index].placeName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Widget _placeDetail(int index) => SizedBox(
        width: 190,
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          text: TextSpan(
            text: list[index].placeDetail,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );

  Widget _popularListCardRatingAndReview(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _starIcon(),
          const Space(width: 2),
          _ratingNumber(index),
          const Space(width: 3),
          _reviews(index),
        ],
      );

  Widget _starIcon() => const Icon(
        Icons.star,
        color: Colors.amber,
      );

  Widget _ratingNumber(int index) => Text(
        list[index].rating,
        style: const TextStyle(color: Colors.amber),
      );

  Widget _reviews(int index) => Text(list[index].review);
}
