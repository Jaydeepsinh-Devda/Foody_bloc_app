import 'package:flutter/material.dart';

class NotificationAndPromoHeading extends StatelessWidget {
  final String headline;
  const NotificationAndPromoHeading({
    required this.headline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Text(
              headline,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
