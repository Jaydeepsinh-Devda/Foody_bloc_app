import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/view/details/details_screen.dart';

class RecommendedList extends StatelessWidget {
  final List<PlaceListModel> list;

  const RecommendedList({
    required this.list,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailsScreen.tag,
                  arguments: {'id': list[index].id});
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _recommendedCardImage(index),
                _recommendedPlaceNameAndLocation(index),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _recommendedPlaceNameAndLocation(int index) => Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _recommendedPlaceName(index),
            _recommendedLocation(index),
          ],
        ),
      );

  Widget _recommendedCardImage(int index) => SizedBox(
        width: 200,
        height: 250,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          child: Image.asset(
            list[index].imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      );
  Widget _recommendedPlaceName(int index) => Text(
        list[index].placeName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _recommendedLocation(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.white,
          ),
          Text(
            list[index].placeLocation,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
}
