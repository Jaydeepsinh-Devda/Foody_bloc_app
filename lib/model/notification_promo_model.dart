import 'package:flutter/material.dart';

enum NotificationCategory { info, promo, transaction }

class NotificationPromoModel {
  final IconData icon;
  final NotificationCategory category;
  final String headline;
  final String detail;
  final String? dueDate;
  final String? date;

  const NotificationPromoModel({
    required this.icon,
    required this.category,
    required this.headline,
    required this.detail,
    this.dueDate,
    this.date,
  });
}
