import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';

class RecommendedCard extends StatelessWidget {
  final PlaceListModel element;

  const RecommendedCard({
    required this.element,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _recommendedCardImage(),
          _recommendedPlaceNameAndLocation(),
        ],
      ),
    );
  }

  Widget _recommendedPlaceNameAndLocation() => Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _recommendedPlaceName(),
            _recommendedLocation(),
          ],
        ),
      );

  Widget _recommendedCardImage() => SizedBox(
        width: 200,
        height: 250,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            element.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      );
  Widget _recommendedPlaceName() => Text(
        element.placeName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _recommendedLocation() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
          ),
          Text(
            element.placeLocation,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
}
