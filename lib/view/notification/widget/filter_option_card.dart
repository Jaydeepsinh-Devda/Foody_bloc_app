import 'package:flutter/material.dart';
import 'package:foody_bloc_app/model/notification_model.dart';
import 'package:foody_bloc_app/view/notification/cubit/notification_cubit.dart';

class FilterOptionCard extends StatelessWidget {
  final NotificationCubit bloc;
  final NotificationCategory element;
  final int index;

  const FilterOptionCard({
    required this.bloc,
    required this.index,
    required this.element,
    super.key,
  });

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: GestureDetector(
        onTap: () {
          bloc.onFilterCardIndexChange(element.index);
        },
        child: _filterCard(),
      ),
    );
  }

  //! Widget Methods
  Widget _filterCard() => Card(
        color: element.index == index ? Colors.amber : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: _filterCardText(),
        ),
      );

  Widget _filterCardText() => Text(
        element.name.toUpperCase(),
        style: const TextStyle(fontSize: 10),
      );
}
