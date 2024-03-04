import 'package:flutter/material.dart';
import 'package:foody_bloc_app/data/carousel_image_list.dart';

class Carousel extends StatelessWidget {
  final PageController pageController;

  const Carousel({
    required this.pageController,
    super.key,
  });

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 350,
        child: _pageViewBuilder());
  }

  //! Widget Methods
  Widget _pageViewBuilder() => PageView.builder(
        controller: pageController,
        itemCount: carouselImages.length,
        itemBuilder: (context, index) {
          return _carouselImages(index);
        },
      );

  Widget _carouselImages(int index) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        child: Image.asset(
          carouselImages[index],
          fit: BoxFit.cover,
        ),
      );
}
