import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<String> imageUrls;
  final PageController pageController;

  const Carousel({
    required this.pageController,
    required this.imageUrls,
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
        itemCount: imageUrls.length,
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
          imageUrls[index],
          fit: BoxFit.cover,
        ),
      );
}
