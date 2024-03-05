import 'package:flutter/material.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/model/place_list_model.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class AboutTab extends StatelessWidget {
  final PlaceListModel element;

  const AboutTab({
    required this.element,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 20),
            child: _descriptionAndAboutPlaceText()),
      )
    ]);
  }

  Widget _descriptionAndAboutPlaceText() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _descriptionText(),
          const Space(height: 10),
          _aboutPlaceText(),
        ],
      );

  Widget _descriptionText() => Text(
        FoodyAppStrings.kDescription,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _aboutPlaceText() => Text(
        "${element.placeName}, ${element.aboutPlace}",
        textAlign: TextAlign.justify,
      );
}
