import 'package:flutter/material.dart';

enum NotificationCategory { info, promo, transaction }

class NotificationPromoModel {
  final IconData icon;
  final Color iconColor;
  final NotificationCategory notificationCategory;
  final String headline;
  final String detail;
  final String? dueDate;
  final String? date;

  const NotificationPromoModel({
    required this.icon,
    required this.iconColor,
    required this.notificationCategory,
    required this.headline,
    required this.detail,
    this.dueDate,
    this.date,
  });
}
