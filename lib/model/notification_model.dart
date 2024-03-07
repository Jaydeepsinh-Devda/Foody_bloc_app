import 'package:flutter/material.dart';

enum NotificationCategory { all, info, promo, transaction }

enum PromoCategory { hottest, recommendation }

class NotificationModel {
  final IconData icon;
  final Color iconColor;
  final NotificationCategory notificationCategory;
  final String headline;
  final String detail;
  final String? dueDate;
  final String? date;
  final PromoCategory? promoCategory;

  const NotificationModel({
    required this.icon,
    required this.iconColor,
    required this.notificationCategory,
    required this.headline,
    required this.detail,
    this.promoCategory,
    this.dueDate,
    this.date,
  });
}
