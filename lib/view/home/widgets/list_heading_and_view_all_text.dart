import 'package:flutter/material.dart';
import 'package:foody_bloc_app/constants/strings.dart';

class ListHeadingAndViewAllText extends StatelessWidget {
  final String headingText;

  const ListHeadingAndViewAllText({
    required this.headingText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headingText,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          FoodyAppStrings.kViewAll,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
