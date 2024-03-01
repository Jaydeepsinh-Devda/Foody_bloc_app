import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/notification_promo_model.dart';

List<NotificationPromoModel> notificationPromoData = const [
  NotificationPromoModel(
    icon: Icons.wallet,
    category: NotificationCategory.transaction,
    headline: "Top Up INR 200.00",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    date: "1 March 2024"
  ),
  NotificationPromoModel(
    icon: Icons.volume_up,
    category: NotificationCategory.info,
    headline: "Food Delivery",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    date: "1 March 2024"
  ),
  NotificationPromoModel(
    icon: Icons.local_offer_outlined,
    category: NotificationCategory.promo,
    headline: "40% Discount",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    dueDate: "3 March 2024"
  ),
  NotificationPromoModel(
    icon: Icons.wallet,
    category: NotificationCategory.transaction,
    headline: "Top Up INR 200.00",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    date: "29 Feb 2024"
  ),
  NotificationPromoModel(
    icon: Icons.local_offer_outlined,
    category: NotificationCategory.promo,
    headline: "40% Discount",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    dueDate: "5 March 2024"
  ),
  NotificationPromoModel(
    icon: Icons.local_offer_outlined,
    category: NotificationCategory.promo,
    headline: "40% Discount",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    dueDate: "10 March 2024"
  ),
  NotificationPromoModel(
    icon: Icons.local_offer_outlined,
    category: NotificationCategory.promo,
    headline: "40% Discount",
    detail: "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum",
    dueDate: "15 March 2024"
  ),
];
