import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class PopularCard extends StatelessWidget {
  final PlaceListModel element;
  const PopularCard({
    required this.element,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              _popularListCardImage(),
              const Space(width: 10),
              _popularListCardPlaceDetails()
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularListCardImage() => Container(
        clipBehavior: Clip.antiAlias,
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          element.imageUrl,
          fit: BoxFit.cover,
        ),
      );

  Widget _popularListCardPlaceDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            element.placeName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 190,
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              text: TextSpan(
                text: element.placeDetail,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          _popularListCardRatingAndReview()
        ],
      );

  Widget _popularListCardRatingAndReview() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          Text(
            element.rating,
            style: const TextStyle(color: Colors.amber),
          ),
          Text(element.review)
        ],
      );
}
