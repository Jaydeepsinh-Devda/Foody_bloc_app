import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class NotificationAndPromoCard extends StatelessWidget {
  final NotificationPromoModel element;

  const NotificationAndPromoCard({
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
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              _icon(),
              const Space(width: 20),
              _cardDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon() => CircleAvatar(
        minRadius: 20,
        backgroundColor: Colors.red[50],
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.local_offer_outlined,
            color: Colors.red,
          ),
        ),
      );

  Widget _cardDetail() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _cardCategoryAndDate(),
            _headlineText(),
            _promoDetail()
          ],
        ),
      );

  Widget _cardCategoryAndDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            element.category.name.toUpperCase(),
            style: _detailTextColor(),
          ),
          Text(
            "Until ${element.dueDate}",
            style: _detailTextColor(),
          ),
        ],
      );

  TextStyle _detailTextColor() => const TextStyle(color: Colors.grey);

  Widget _headlineText() => Text(
        element.headline,
        style: const TextStyle(fontWeight: FontWeight.bold),
      );

  Widget _promoDetail() => RichText(
        text: TextSpan(
          text: element.detail,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
      );
}
