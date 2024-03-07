import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/notification_model.dart';
import 'package:foody_bloc_app/ui_components/space.dart';

class NotificationAndPromoCard extends StatelessWidget {
  final NotificationModel element;

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
        backgroundColor: element.iconColor.withOpacity(0.2),
        child: Icon(
          element.icon,
          color: element.iconColor,
        ),
      );

  Widget _cardDetail() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _cardCategoryAndDate(),
            _headlineText(),
            _promoDetail(),
          ],
        ),
      );

  Widget _cardCategoryAndDate() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _categoryText(),
          _dateText(),
        ],
      );

  Widget _categoryText() => Text(
        element.notificationCategory.name.toUpperCase(),
        style: _detailTextColor(),
      );

  Widget _dateText() => Text(
        "Until ${element.date ?? element.dueDate}",
        style: _detailTextColor(),
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
